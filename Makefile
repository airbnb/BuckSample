
.PHONY : log install_buck build targets pods audit debug test xcode_tests clean project audit

# Use system version of Buck
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
	$(BUCK) build //App:ExampleAppBundle

debug:
	$(BUCK) install //App:ExampleAppBundle --run --simulator-name 'Phone: iPhone Xs'

targets:
	$(BUCK) targets //...

ci: targets build test project xcode_tests
	echo "Done"

test:
	$(BUCK) test //App/Tests:Tests --all --exclude ui --test-runner-env FOO=BAR

ui_test:
	$(BUCK) test //App/UITests:UITests

pods:
	$(BUCK) build //Pods:PromiseKit
	$(BUCK) build //Pods:Braintree
	# $(BUCK) build //Pods:Nimble

audit:
	$(BUCK) audit rules App/BUCK > Config/Gen/App-BUCK.py
	$(BUCK) audit rules Pods/BUCK > Config/Gen/Pods-BUCK.py

clean:
	killall Xcode || true
	killall Simulator || true
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	$(BUCK) clean

xcode_tests: project
	xcodebuild build test -workspace App/ExampleApp.xcworkspace -scheme ExampleApp -destination 'platform=iOS Simulator,name=iPhone 8,OS=latest' | xcpretty && exit ${PIPESTATUS[0]}

project: clean
	$(BUCK) project //App:workspace
	open App/ExampleApp.xcworkspace
