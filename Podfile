# Set the platform globally
platform :ios, '10.0'

# Only download the files, don't create Xcode projects
install! 'cocoapods', integrate_targets: false

target 'BuckSample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'CryptoSwift'
  pod 'Bugsnag'
  pod 'PromiseKit/CorePromise', '6.1.1'
  pod 'PromiseKit/CoreLocation', '6.1.1'

  target 'BuckSampleTests' do
    inherit! :search_paths
  end

  target 'BuckSampleUITests' do
    inherit! :search_paths

    pod 'EarlGrey'
  end

end
