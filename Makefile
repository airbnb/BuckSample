
.PHONY : log install_buck build watch message targets pods audit debug test xcode_tests clean project audit

# Use local version of Buck
BUCK=tools/buck

log:
	echo "Make"

install_buck:
	curl https://jitpack.io/com/github/airbnb/buck/e5f6ac31436ae6be76880ebcf50607c98a9a8bbd/buck-e5f6ac31436ae6be76880ebcf50607c98a9a8bbd.pex --output tools/buck
	chmod u+x tools/buck

update_cocoapods:
	pod repo update
	pod install

build:
	$(BUCK) build //App:ExampleApp

watch:
	$(BUCK) build //App:ExampleWatchAppExtension#watchsimulator-i386

message:
	$(BUCK) build //App:ExampleMessageExtension

debug:
	$(BUCK) install //App:ExampleApp --run --simulator-name 'Phone: iPhone XS'

targets:
	$(BUCK) targets //...

ci: install_buck targets build test project xcode_tests watch message
	echo "Done"

test:
	$(BUCK) test //App:ExampleAppCITests --test-runner-env FOO=BAR

ui_test:
	$(BUCK) test //App:UITests

pods:
	$(BUCK) build //Pods:PromiseKit
	$(BUCK) build //Pods:Braintree
	$(BUCK) build //Pods:Bugsnag
	# $(BUCK) build //Pods:Nimble

audit:
	$(BUCK) audit rules App/BUCK > Config/Gen/App-BUCK.py
	$(BUCK) audit rules Pods/BUCK > Config/Gen/Pods-BUCK.py

clean:
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	rm -rf buck-out

kill_xcode:
	killall Xcode || true
	killall Simulator || true

xcode_tests: project
	xcodebuild build test -workspace App/ExampleApp.xcworkspace -scheme ExampleApp -destination 'platform=iOS Simulator,name=iPhone 8,OS=latest' | xcpretty && exit ${PIPESTATUS[0]}

project: clean
	$(BUCK) project //App:workspace
	open App/ExampleApp.xcworkspace
