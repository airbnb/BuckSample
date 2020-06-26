ROOT_DIR = File.expand_path('.', __dir__)
$LOAD_PATH << "#{ROOT_DIR}/BuckLocal/ruby_scripts"

require 'project_generator'
require 'builder'
require 'common'

namespace :buck_local do
  desc 'Generate BuckLocal Xcode workspace for the app.'
  task :generate_project do
    raise 'Please specify "buck_binary_path"' if ENV['buck_binary_path'].nil?

    raise 'Please specify "workspace_target"' if ENV['workspace_target'].nil?
    raise 'Please specify "top_level_lib_target"' if ENV['top_level_lib_target'].nil?

    buck_local_project_generator = BuckLocal::ProjectGenerator.new(ENV['workspace_target'], ENV['top_level_lib_target'])
    buck_local_project_generator.generate_project()
  end

  task :build_and_copy do
    # e.g. $REPO_ROOT/BuckLocal/lib_targets.list
    argument_or_fail 'buck_binary_path'
    deps_list_file = argument_or_fail 'deps_list_file'

    BuckLocal::Builder.new.build_and_copy_deps(deps_list_file: deps_list_file)
  end
end
