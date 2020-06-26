ROOT_DIR = File.expand_path('.', __dir__)
$LOAD_PATH << "#{ROOT_DIR}/BuckLocal/ruby_scripts"

require 'project_generator'

namespace :generate do
  desc 'Generate BuckLocal Xcode workspace for the app.'
  task :buck_local_project do
    raise 'Please specify "buck_binary_path"' if ENV['buck_binary_path'].nil?

    raise 'Please specify "workspace_target"' if ENV['workspace_target'].nil?
    raise 'Please specify "top_level_lib_target"' if ENV['top_level_lib_target'].nil?

    buck_local_project_generator = BuckLocal::ProjectGenerator.new(ENV['workspace_target'], ENV['top_level_lib_target'])
    buck_local_project_generator.generate_project()
  end
end
