require 'common'
require 'json'

module BuckLocal
  # A class encapsulating buck targerts
  class Targets
    NAME = 'name'
    QUALIFIED_NAME = 'fully_qualified_name'
    TYPE = 'buck.type'
    MODULAR = 'modular'
    OUTPUT_PATH = 'buck.outputPath'
    LINKER_FLAGS = 'exportedLinkerFlags'
    COMMON_ATTRIBUTES = [NAME, QUALIFIED_NAME, TYPE, MODULAR, LINKER_FLAGS]

    # @param top_target_name: the name of a top level target, e.g. //ios/path/ModuleA:ModuleA
    def initialize(target_names)
      # In Buck Local, apple_bundle is tricky. Instead of Buck, we let Xcode to build apple_bundle targets.
      # So we exclude all apple_bundle targets and their dependencies from the query.
      @apple_bundle_deps_target_names = Targets.get_query_output("deps(kind('apple_bundle', set(#{target_names.join(' ')})))").lines.map(&:chomp)
      target_names = (target_names.to_set - @apple_bundle_deps_target_names.to_set).to_a
      @targets = JSON.parse(Targets.get_command_output("targets #{target_names.join(' ')} --output-attributes #{COMMON_ATTRIBUTES.join(' ')}"))
    end

    # A list of prebuilt_cxx_library targets
    # Each target contains the output path of the .a file if there is.
    def apple_library_targets
      if @apple_library_targets.nil?
        # For apple_library, we need their output path (the location of the .a files).
        # We can only get the output path from the query of their fully qualified names, e.g. //ios/Module:Module#iphonesimulator-x86_64,static
        target_qualified_names = self.class.qualified_names(filter_targets(@targets, 'apple_library'))
        @apple_library_targets = JSON.parse(Targets.get_command_output("targets #{target_qualified_names.join(' ')} --show-output --output-attributes #{COMMON_ATTRIBUTES.join(' ')} #{OUTPUT_PATH}"))
      end
      @apple_library_targets
    end

    # A list of prebuilt_cxx_library targets
    # Each target contains the path of the of library.
    def prebuilt_cxx_library_targets
      if @prebuilt_cxx_library_targets.nil?
        target_qualified_names = self.class.qualified_names(filter_targets(@targets, 'prebuilt_cxx_library'))
        if target_qualified_names.empty?
          @prebuilt_cxx_library_targets = {}
          return @prebuilt_cxx_library_targets
        end

        targets = JSON.parse(Targets.get_command_output("targets #{target_qualified_names.join(' ')} --json"))
        @prebuilt_cxx_library_targets = targets.map do |prebuilt_cxx_library_target|
          # Trying to figure out the actual path of the prebuilt library.
          static_lib = prebuilt_cxx_library_target['staticLib']
          base_path = prebuilt_cxx_library_target['buck.base_path']
          prebuilt_cxx_library_target[OUTPUT_PATH] = if static_lib.start_with?(':')
                                                       # if the static lib is a genrule, we need to find the actual output path.
                                                       File.join(JSON.parse(Targets.get_command_output("targets #{base_path}#{static_lib} --json --show-output --output-attributes #{OUTPUT_PATH}")).first[OUTPUT_PATH])
                                                     else
                                                       File.join(base_path, static_lib)
                                                     end
          prebuilt_cxx_library_target
        end
      end
      @prebuilt_cxx_library_targets
    end

    # A list of apple_asset_catalog targets
    def apple_asset_catalog_targets
      filter_targets(@targets, 'apple_asset_catalog')
    end

    # A list of apple_resource targets
    def apple_resource_targets
      filter_targets(@targets, 'apple_resource')
    end

    # A list of apple_resource targets
    def prebuilt_apple_framework_targets
      filter_targets(@targets, 'prebuilt_apple_framework')
    end

    # A list of apple_bundle targets
    def apple_bundle_targets
      if @apple_bundle_targets.nil?
        @apple_bundle_targets = []
        unless @apple_bundle_deps_target_names.empty?
          apple_bundle_deps_targets = JSON.parse(Targets.get_command_output("targets #{@apple_bundle_deps_target_names.join(' ')} --output-attributes #{COMMON_ATTRIBUTES.join(' ')}"))
          @apple_bundle_targets = filter_targets(apple_bundle_deps_targets, 'apple_bundle')
        end
      end
      @apple_bundle_targets
    end

    # Consodidate exported linker flags from apple_library and prebuilt_cxx_library
    def exported_linker_flags
      (filter_targets(@targets, 'apple_library') + filter_targets(@targets, 'prebuilt_cxx_library')).map { |json| json[LINKER_FLAGS] }.compact.flatten
    end

    # Filter a list of Buck targets based on the target type.
    def filter_targets(targets, target_type)
      targets.select { |target| target[TYPE] == target_type }
    end

    # Return a of list of qualified names for given targets.
    def self.qualified_names(targets)
      targets.map { |target| target[QUALIFIED_NAME] }
    end

    def self.all_deps(target_name)
      self.get_query_output("deps('#{target_name}')").lines.map(&:chomp)
    end

    def self.get_query_output(query_string)
      system_output "#{ENV['buck_binary_path']} query \"#{query_string}\""
    end

    def self.get_command_output(command_string)
      system_output "#{ENV['buck_binary_path']} #{command_string}"
    end
  end
end
