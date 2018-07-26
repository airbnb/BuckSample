
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

workspace 'Untitled.xcworkspace'
project 'Test/Test.xcodeproj'

def Braintree
  pod "Braintree", '4.8.5'
  pod "Braintree/DataCollector", '4.8.5'
  pod "Braintree/Apple-Pay", '4.8.5'
end

target 'Test' do
  inherit! :search_paths
  use_frameworks!

  pod 'PromiseKit'
  pod 'Quick'
  pod 'Nimble'
  Braintree()
end
