
.PHONY : log install_buck build targets pods audit debug test

BUCK=buck
# BUCK=tools/buck.pex # Custom version

log:
	echo "Make"

install_buck: 
    curl https://jitpack.io/com/github/airbnb/buck/b652367c2b017ddce7fc0f94cb62ef6fd4138cf0/buck-b652367c2b017ddce7fc0f94cb62ef6fd4138cf0.pex --output tools/buck
	chmod u+x tools/buck

update_cocoapods:
	pod repo update
	pod install

build:
	$(BUCK) build //BuckSample:BuckSampleLibrary

debug:
	$(BUCK) install //BuckSample:BuckSampleBundle --run

targets:
	$(BUCK) targets //...

test:
	$(BUCK) test //BuckSampleTests:BuckSampleTests

ui_test:
	$(BUCK) test //BuckSampleUITests:BuckSampleUITests -v 3

pods:
	$(BUCK) build //Pods:PromiseKit
	$(BUCK) build //Pods:Braintree
	$(BUCK) build //Pods:Nimble

audit:
	$(BUCK) audit rules Pods/BUCK

project:
	rm -rf BuckSample/BuckSample.xcodeproj
	rm -rf BuckSample/BuckSample.xcworkspace
	killall Xcode || true
	$(BUCK) project //BuckSample:workspace
	ls BuckSample
	open BuckSample/BuckSample.xcworkspace
