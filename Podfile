# Set the platform globally
platform :ios, '10.0'

# Only download the files, don't create Xcode projects
install! 'cocoapods', integrate_targets: false 

target 'BuckSample' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'PromiseKit'
  pod 'Braintree'
  pod 'Braintree/DataCollector'
  pod 'Braintree/Apple-Pay'

  target 'BuckSampleTests' do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
  end

  target 'BuckSampleUITests' do
    inherit! :search_paths

    pod 'EarlGrey'
  end

end
