ROOT_DIR = File.expand_path('.', __dir__)
$LOAD_PATH << "#{ROOT_DIR}/BuckLocal/ruby_scripts"

require 'project_generator'
require 'builder'
require 'common'

namespace :buck_local do
  desc 'Generate BuckLocal Xcode workspace for the app.'
  task :generate_project do
    argument_or_fail 'buck_binary_path'
    workspace_target = argument_or_fail 'workspace_target'
    top_level_lib_target = argument_or_fail 'top_level_lib_target'
    xcworkspace = argument_or_fail 'xcworkspace'

    buck_local_project_generator = BuckLocal::ProjectGenerator.new(workspace_target, top_level_lib_target, xcworkspace)
    buck_local_project_generator.generate_project()
  end

  task :build_and_copy do
    # e.g. $REPO_ROOT/BuckLocal/lib_targets.list
    argument_or_fail 'buck_binary_path'
    deps_list_file = argument_or_fail 'deps_list_file'

    BuckLocal::Builder.new.build_and_copy_deps(deps_list_file: deps_list_file)
  end
end
