
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'

workspace 'Untitled.xcworkspace'
project 'Test/Test.xcodeproj'

def Braintree
  pod "Braintree", '4.8.1'
  pod "Braintree/DataCollector", '4.8.1'
  pod "Braintree/Apple-Pay", '4.8.1'
end

def PromiseKit
  pod "PromiseKit/CorePromise", '4.0.5'
  pod "PromiseKit/CoreLocation", '4.0.5'
end

def TestPods
  pod 'Quick', '~> 1.0'
  pod 'Nimble', '~> 7.0'
end

target 'Test' do
  inherit! :search_paths
  use_frameworks!
  Braintree()
  PromiseKit()
  TestPods()
end
