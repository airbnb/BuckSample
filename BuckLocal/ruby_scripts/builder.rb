require 'buck_log_formatter'
require 'common'
require 'json'
require 'fileutils'

module BuckLocal
  # This class defines the methods helping build inside Xcode
  class Builder
    def initialize
    end

    #
    # Build dependencies via Buck and copy the artifacts to Xcode's DerivedData directory so that Xcode can find them.
    #
    # @param [String] deps_list_file Path to a file that contains a list of all dependencies need to be built
    #
    def build_and_copy_deps(deps_list_file:)
      # Disable STDOUT buffers, so we can get realtime build log.
      $stdout.sync = true

      # Build all dependencies
      dep_list = JSON.parse(File.read(deps_list_file))
      build_deps_and_format_for_xcode(deps_list: dep_list)

      prepare_for_artifacts_copying
      # Copy build artifacts of dependencies to derived data for Xcode to consume
      dep_list.map { |dep| dep[DEP_TARGET_NAME] }.each do |dep_target|
        copy_artifacts_of_target(buck_target: dep_target)
      end
    end

    #
    # Build all dependencies listed in a given file, and format the output in a format that Xcode can parse.
    #
    # @param [String] deps_list A list of all dependencies need to be built.
    #
    def build_deps_and_format_for_xcode(deps_list:)
      Dir.chdir ENV['REPO_ROOT'] do
        log 'Build all dependencies and format output for Xcode.'

        # e.g. iphonesimulator-x86_64 or iphoneos-arm64, EFFECTIVE_PLATFORM_NAME has a "-" prefix that we need to get rid of
        flavor = "#{ENV['EFFECTIVE_PLATFORM_NAME'][1..-1]}-#{ENV['ARCHS']}"
        # 1. Read Buck rules from cached list. The list is generated in buck_local.rb.
        # 2. Append flavors to the Buck rules, e.g. //ios/lib/Module -> //ios/lib/Module#iphoneos-arm64,static.
        deps_targets_list = deps_list.map { |dep| "#{dep['target_name']}##{flavor},static" }

        # Build all dependencies via Buck, and format its output via BuckLogFormatter
        buck_log_formatter = BuckLogFormatter.new
        build_deps_command = "#{ENV['buck_binary_path']} build #{deps_targets_list.join(' ')}"
        log build_deps_command
        Open3.popen2e(build_deps_command) do |_, stdout_and_stderr, wait_thread|
          stdout_and_stderr.each do |line|
            buck_log_formatter.format_line(line)
          end
          # Exit if the build fails.
          if wait_thread.value != 0
            exit wait_thread.value.exitstatus
          end
        end

        # If the artifacts of "#iphonesimulator-x86_64,static" is cached, they will be downloaded directly without
        # building modulemap and swfitmodule, which are required for debugging, so we need to build them separately.
        # Building with flavor "#header-mode-symlink-tree-with-umbrella-header-modulemap,headers,iphonesimulator-x86_64" will trigger
        # "#apple-swift-compile,iphonesimulator-x86_64" which contains the swiftmodule file.
        module_map_headers_list = deps_list.select { |dep| dep[BuckLocal::DEP_TARGET_MODULAR] }.map { |dep| "#{dep['target_name']}#header-mode-symlink-tree-with-umbrella-header-modulemap,headers,#{flavor}" }
        system_and_log "#{ENV['buck_binary_path']} build #{module_map_headers_list.join(' ')}"
      end
    end

    #
    # To copy artifacts from buck-out to Derived Data, we need to construct a few important
    # parameters based on the environment variables passed in by xcodebuild.
    #
    def prepare_for_artifacts_copying
      # Prepare the environment variables
      @repo_root = ENV['REPO_ROOT']
      # e.g. -iphonesimulator or -iphoneos
      effective_platform_name = ENV['EFFECTIVE_PLATFORM_NAME']
      # e.g. x86_64 or arm64
      @target_arch = ENV['ARCHS']
      # e.g. iphonesimulator-x86_64 or iphoneos-arm64, effective_platform_name has a "-" prefix that we need to get rid of
      @flavor = "#{effective_platform_name[1..-1]}-#{@target_arch}"
      # Build/Products/Debug-iphonesimulator or Build/Products/Debug-iphoneos
      @products_dir = (ENV['BUILT_PRODUCTS_DIR']).to_s
      create_directory(@products_dir, quiet: true)
    end

    # Copy the module map directory if it exists from buck-out to target Derived Data directory
    def copy_module_map_dir_if_exist(source_module_map_dir, dest_module_map_dir)
      if Dir.exist?(source_module_map_dir)
        create_directory(dest_module_map_dir, quiet: true)
        Dir.foreach(source_module_map_dir) do |item|
          source_file_path = "#{source_module_map_dir}/#{item}"
          dest_file_path = "#{dest_module_map_dir}/#{item}"
          copy_if_updated(source_file_path, dest_file_path)
        end
      end
    end

    #
    # Copy artifacts of a given buck target from buck-out to the BUILD_PRODUCTS_DIR in Derived Data
    #
    # @param [String] buck_target the fully qualified name of a buck target, e.g.: //ios/lib/Module:Module
    #
    def copy_artifacts_of_target(buck_target:)
      # Covert the target to a relative path, e.g. //ios/lib/Module:Module -> ios/lib/Module/Module
      lib_relative_path = buck_target[2..-1].sub(':', '/').chomp
      # Get the name of the module, e.g. ios/lib/Module/Module -> Module
      module_name = lib_relative_path.split('/')[-1]

      # Copy ".a" for linking the final product
      source_lib_path = "#{@repo_root}/buck-out/gen/#{lib_relative_path}\##{@flavor},static/lib#{module_name}.a"
      dest_lib_path = File.join(@products_dir, "lib#{module_name}.a")
      copy_if_updated(source_lib_path, dest_lib_path) if File.exist?(source_lib_path)

      # Copy ".swiftmodule" if needed to enable debugging Swift code
      swift_module_path = "#{@repo_root}/buck-out/gen/#{lib_relative_path}#apple-swift-compile,#{@flavor}/#{module_name}.swiftmodule"
      if File.exist?(swift_module_path)
        # Xcode expects every swift module to be under *.swiftmodule directory, so we
        # create the target directory before copy over the .swiftmodule file.
        module_dir_name = swift_module_path.split('/')[-1]
        create_directory("#{@products_dir}/#{module_dir_name}", quiet: true)
        copy_if_updated(swift_module_path, "#{@products_dir}/#{module_dir_name}/#{@target_arch}.swiftmodule")
      end

      # Copy headers and modulemaps for compiling, linking and debugging ObjC code
      possible_source_module_map_dirs = [
        "#{@repo_root}/buck-out/gen/#{lib_relative_path}#header-mode-symlink-tree-with-header-map,headers/#{module_name}",
        "#{@repo_root}/buck-out/gen/#{lib_relative_path}#header-mode-symlink-tree-with-modulemap,headers,#{@flavor}/#{module_name}",
        "#{@repo_root}/buck-out/gen/#{lib_relative_path}#header-mode-symlink-tree-with-umbrella-header-modulemap,headers,#{@flavor}/#{module_name}",
      ]
      dest_module_map_dir = "#{@products_dir}/#{module_name}"
      possible_source_module_map_dirs.each do |source_module_map_dir|
        copy_module_map_dir_if_exist(source_module_map_dir, dest_module_map_dir)
      end
    end
  end
end
