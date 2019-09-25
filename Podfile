# Set the platform globally
platform :ios, '10.0'

plugin 'cocoapods-binary'
use_frameworks!

# Only download the files, don't create Xcode projects
install! 'cocoapods', integrate_targets: false

target 'BuckSample' do
  pod 'CryptoSwift'
  pod 'Bugsnag'
  pod 'PromiseKit/CorePromise', '6.1.1'
  pod 'PromiseKit/CoreLocation', '6.1.1'
  pod "AFNetworking", :binary => true
end
