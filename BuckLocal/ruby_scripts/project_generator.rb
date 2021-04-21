require 'targets'
require 'query'
require 'fileutils'
require 'erb'
require 'xcodeproj'

module BuckLocal
  # This class is used to generate Buck Local Xcode workspace, including Focus project.
  class ProjectGenerator
    def initialize(workspace_target, top_level_lib_target, xcworkspace)
      @workspace_target = workspace_target
      @top_level_lib_target = top_level_lib_target
      @xcworkspace = xcworkspace
    end

    #
    # Generate Buck Local Xcode project
    #
    def generate_project()
      # Generate BuckLocal/BUCK file for BuckLocal
      generate_buck_local_buck_file

      # Create Xcode project
      system_output "#{ENV['buck_binary_path']} project #{@workspace_target}"

      # After Xcode project has been generated, we need to update the project in order
      # to get BuckLocal working
      update_xcconfig_files
      update_main_scheme
    end

    private

    # This method generates "BuckLocal/BUCK" based on "BuckLocal/BUCK.erb".
    # It figures out all the variables needed, and generates the BUCK file via ERB templating.
    def generate_buck_local_buck_file
      output_file_path = "#{ROOT_DIR}/BuckLocal/lib_targets.list"
      buck_file = "#{ROOT_DIR}/BuckLocal/BUCK"

      # This is required for the first time when BuckLocal/Buck doesn't exist.
      FileUtils.touch(buck_file)

      deps_targets = Targets.new(Targets.all_deps(@top_level_lib_target))

      # Save the deps list into a file which will be used in build phase.
      Query.generate_deps_list_file(deps_targets.apple_library_targets, output_file_path)

      # Generate the linker flag to link with all Buck built libraries when building the App binary.
      libraries_linker_flag = deps_targets.apple_library_targets.select { |path| path.key?(BuckLocal::Targets::OUTPUT_PATH) }.map do |path|
        # The `[3..-3]`` operator gets rid of the "lib" prefix and the ".a" suffix from the filename
        '-l' + File.basename(path[BuckLocal::Targets::OUTPUT_PATH])[3..-3]
      end

      # Generate the linker flag to link with all prebuilt libraries when building the App binary.
      prebuild_libraries_linker_flag = deps_targets.prebuilt_cxx_library_targets.map do |prebuilt_cxx_library_target|
        File.join('$REPO_ROOT', prebuilt_cxx_library_target[BuckLocal::Targets::OUTPUT_PATH])
      end

      # Variables that passed to ERB template for generating the BUCK file
      exported_linker_flags_from_libraries = deps_targets.exported_linker_flags
      libraries = libraries_linker_flag
      prebuilt_libraries = prebuild_libraries_linker_flag
      asset_catalogs = Targets.qualified_names(deps_targets.apple_asset_catalog_targets)
      resources = Targets.qualified_names(deps_targets.apple_resource_targets)
      bundles = Targets.qualified_names(deps_targets.apple_bundle_targets)
      prebuilt_dynamic_frameworks = Targets.qualified_names(deps_targets.prebuilt_apple_framework_targets)

      # Actually generate the BUCK file using ERB.
      buck_template = ERB.new(File.read("#{ROOT_DIR}/BuckLocal/BUCK.erb"))
      File.open(buck_file, 'w') do |f|
        f.write buck_template.result(binding)
      end
    end

    #
    # Remove `HEADER_SEARCH_PATHS` and `SWIFT_INCLUDE_PATHS` to avoid duplicated definitions between
    # BuckLocal build and Xcode build.
    #
    def update_xcconfig_files
      # Get all files whose name matches "*-Debug.xcconfig" under buck-out
      Dir.glob("#{ROOT_DIR}/buck-out/**/*-Debug.xcconfig").each do |xcconfig_file|
        xcconfig_content = contents_of_file(xcconfig_file)
        xcconfig_content = xcconfig_content.lines.map(&:chomp).reject { |line| line.start_with?('HEADER_SEARCH_PATHS') || line.start_with?('SWIFT_INCLUDE_PATHS') }
        write_to_file(xcconfig_content, xcconfig_file)
      end
    end

    #
    # Disable `build_implicit_dependencies` and `parallelize_buildables` for "BuckLocal" xcscheme.
    # Uncheck unnecessary build action entries from scheme.
    #
    def update_main_scheme
      scheme_name = @xcworkspace.split('/').last.split('-').first
      scheme_path = "#{ROOT_DIR}/#{@xcworkspace}/xcshareddata/xcschemes/#{scheme_name}.xcscheme"
      scheme = Xcodeproj::XCScheme.new(scheme_path)
      scheme.build_action.build_implicit_dependencies = false
      scheme.build_action.parallelize_buildables = false

      clear_build_actions(scheme)

      scheme.save!
    end

    def clear_build_actions(scheme)
      scheme.build_action.entries.each do |entry|
        # the name displayed in scheme editor
        entry_target_name = entry.buildable_references.first.target_name

        # skip if this is a test target or a BuckLocal target, or a HostApp
        next if entry_target_name.end_with?('Tests') || entry_target_name.include?('BuckLocal') || entry_target_name.end_with?('HostApp')

        entry.build_for_running = false
        entry.build_for_profiling = false
        entry.build_for_archiving = false
        entry.build_for_analyzing = false
        entry.build_for_testing = false
      end
    end

  end
end
