
.PHONY : log install_buck build targets pods audit debug test

BUCK=buck

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
	$(BUCK) test //BuckSample:BuckSampleTests

ui_test:
	$(BUCK) test //BuckSample:BuckSampleUITests -v 3

pods:
	$(BUCK) build //Pods:PromiseKit
	$(BUCK) build //Pods:Braintree
	$(BUCK) build //Pods:Nimble

audit:
	tools/buck.pex audit rules Pods/BUCK
