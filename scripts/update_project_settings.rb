require 'xcodeproj'

repo_root = `git rev-parse --show-toplevel`.strip()
scheme = Xcodeproj::XCScheme.new("#{repo_root}/App/ExampleApp.xcworkspace/xcshareddata/xcschemes/ExampleApp.xcscheme")
scheme.build_action.build_implicit_dependencies = false
scheme.save!
