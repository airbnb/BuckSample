require 'shared'
require 'targets'
require 'common'

module BuckLocal
  # A helper class of buck query for Buck Local
  class Query
    #
    # Generate a dependencies list file for a given target, the file is required in order to run BuckLocal.
    #
    # @param [String] target_name The fully qualified name of the Buck target
    # @param [String] output_file_path The path for the generated dependencies list file.
    #
    def self.generate_dep_list_file(target_name, output_file_path)
      targets = Targets.new(Targets.all_deps(target_name))
      libraries = targets.apple_library_targets + targets.cxx_library_targets

      generate_deps_list_file(libraries, output_file_path)
    end

    #
    # Generate a dependencies list file to be used by BuckLocal.
    #
    # @param [List] deps_list A list of targets that should be included in the output file
    # @param [String] output_file_path The path to output file
    #
    def self.generate_deps_list_file(deps_list, output_file_path)
      # Cache query result, which will be used in the Build Phase script.
      target_list = deps_list.map do |target|
        {
          # Remove the flavor from the rule name.
          # //ios/lib/Module:Module#iphonesimulator-x86_64,static -> //ios/lib/Module:Module
          DEP_TARGET_NAME => target['fully_qualified_name'].split('#').first,
          DEP_TARGET_MODULAR => target['modular'],
        }
      end

      write_to_file(target_list.to_json, output_file_path)
    end

    # Get a list of all test rules
    def self.all_unit_test_targets
      Targets.get_query_output('testsof(deps(\'//ios/applications/Airbnb:FirstPartyLibraries\', 1))').lines.map(&:chomp)
    end
  end
end
