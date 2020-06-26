require 'targets'
require 'fileutils'

module BuckLocal
  # This class is used to generate Buck Local Xcode workspace, including Focus project.
  class ProjectGenerator
    def initialize(workspace_target, top_level_lib_target)
      @workspace_target = workspace_target
      @top_level_lib_target = top_level_lib_target
    end

    #
    # Generate Buck Local Xcode project
    #
    def generate_project()
      # Generate BuckLocal/BUCK file for BuckLocal
      generate_buck_local_buck_file
    end

    private

    # This method generates "BuckLocal/BUCK" based on "BuckLocal/BUCK.erb".
    # It figures out all the variables needed, and generates the BUCK file via ERB templating.
    def generate_buck_local_buck_file
      output_file_path = "#{ROOT_DIR}/BuckLocal/lib_targets.list"
      buck_file = "#{ROOT_DIR}/BuckLocal/BUCK"

      # This is required for the first time when BuckLocal/Buck doesn't exist.
      FileUtils.touch(buck_file)
      puts Targets.all_deps(@top_level_lib_target)
    end
  end
end
