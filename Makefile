
.PHONY : log install_buck build targets pods audit debug test xcode_tests clean

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

debug: quit_xcode
	$(BUCK) install //BuckSample:BuckSampleBundle --run -v 3

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

clean: 
	rm -rf BuckSample/*.xcworkspace
	rm -rf BuckSample/*.xcodeproj

quit_xcode:
	killall Xcode || true
	killall Simulator || true

xcode_tests: clean quit_xcode
	$(BUCK) project //BuckSample:workspace
	xcodebuild build test -workspace BuckSample/BuckSample.xcworkspace -scheme BuckSample | xcpretty && exit ${PIPESTATUS[0]}
	open BuckSample/BuckSample.xcworkspace

project: clean quit_xcode
	$(BUCK) project //BuckSample:workspace
	open BuckSample/BuckSampleApp.xcworkspace
