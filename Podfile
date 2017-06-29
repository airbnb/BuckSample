require 'redcarpet'

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
  pod 'Quick', '1.1.0'
  pod 'Nimble', '5.1.1'
end

target 'Test' do
  inherit! :search_paths
  use_frameworks!
  Braintree()
  PromiseKit()
  TestPods()
end
