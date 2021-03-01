
.PHONY : log install_buck build watch message targets audit debug test xcode_tests clean project audit

# Use local version of Buck
BUCK=tools/buck

log:
	echo "Make"

install_buck:
	curl https://jitpack.io/com/github/facebook/buck/25bf7ad90f2297468d807d8a19ec7f420ba3dedd/buck-25bf7ad90f2297468d807d8a19ec7f420ba3dedd-java11.pex --output tools/buck
	chmod u+x tools/buck

update_cocoapods:
	pod repo update
	pod install

build:
	$(BUCK) build //App:ExampleApp

build_release:
	$(BUCK) build //App:ExampleApp --config-file ./BuildConfigurations/Release.buckconfig

watch:
	$(BUCK) build //App:ExampleWatchAppExtension#watchsimulator-i386

message:
	$(BUCK) build //App:ExampleMessageExtension

debug:
	$(BUCK) install //App:ExampleApp --run --simulator-name 'iPhone 8'

debug_release:
	$(BUCK) install //App:ExampleApp --run --simulator-name 'iPhone 8' --config-file ./BuildConfigurations/Release.buckconfig

targets:
	$(BUCK) targets //...

ci: install_buck install_ruby_gems targets build test ui_test ruby_test project xcode_tests watch message
	echo "Done"


buck_out = $(shell $(BUCK) root)/buck-out
TEST_BUNDLE = $(shell $(BUCK) targets //App:ExampleAppCITests --show-output | awk '{ print $$2 }')
test:
	@rm -f $(buck_out)/tmp/*.profraw
	@rm -f $(buck_out)/gen/*.profdata
	$(BUCK) test //App:ExampleAppCITests --test-runner-env XCTOOL_TEST_ENV_LLVM_PROFILE_FILE="$(buck_out)/tmp/code-%p.profraw%15x" \
		--config-file code_coverage.buckconfig
	xcrun llvm-profdata merge -sparse "$(buck_out)/tmp/code-"*.profraw -o "$(buck_out)/gen/Coverage.profdata"
	xcrun llvm-cov report "$(TEST_BUNDLE)/ExampleAppCITests" -instr-profile "$(buck_out)/gen/Coverage.profdata" -ignore-filename-regex "Pods|Carthage|buck-out"

UI_TESTS_TMP = $(shell $(BUCK) root)/build/xcuitest
UI_TESTS_TOOLS = $(shell $(BUCK) root)/tools/xcuitest
TARGET_SIMULATOR = "iPhone 8"
ui_test:
	$(BUCK) build //App:XCUITests
	rm -rf ${UI_TESTS_TMP}
	mkdir -p ${UI_TESTS_TMP}
	ln -sf $(buck_out)/gen/App/XCUITests#apple-test-bundle,dwarf,no-include-frameworks,no-linkermap/XCUITests.xctest $(UI_TESTS_TMP)
	cp $(UI_TESTS_TOOLS)/ExampleApp.xctestrun $(UI_TESTS_TMP)
	unzip $(UI_TESTS_TOOLS)/XCUITests-Runner.app.zip -d $(UI_TESTS_TMP)
	xcrun simctl boot $(TARGET_SIMULATOR) || true
	xcrun simctl install $(TARGET_SIMULATOR) $(UI_TESTS_TMP)/XCUITests.xctest/PlugIns/ExampleApp.app
	xcodebuild test-without-building -xctestrun $(UI_TESTS_TMP)/ExampleApp.xctestrun -destination 'platform=iOS Simulator,name=$(shell echo $(TARGET_SIMULATOR)),OS=latest'

install_ruby_gems:
	bundle install --path vendor/bundle

ruby_test:
	buck_binary_path=tools/buck bundle exec rspec BuckLocal/ruby_scripts/ -I BuckLocal/ruby_scripts/

audit:
	$(BUCK) audit rules App/BUCK > Config/Gen/App-BUCK.py
	$(BUCK) audit rules Pods/BUCK > Config/Gen/Pods-BUCK.py

clean:
	rm -rf **/*.xcworkspace
	rm -rf **/*.xcodeproj
	$(BUCK) clean

kill_xcode:
	killall Xcode || true
	killall Simulator || true

xcode_tests: project
	xcodebuild build test -workspace App/ExampleApp-BUCK.xcworkspace -scheme ExampleApp -destination 'platform=iOS Simulator,name=iPhone 8,OS=latest' | xcpretty && exit ${PIPESTATUS[0]}

project: clean
	$(BUCK) project //App:workspace
	open App/ExampleApp-BUCK.xcworkspace

buck_local_project: clean
	bundle exec rake buck_local:generate_project buck_binary_path=$(BUCK) workspace_target='//App:workspace-buck-local' top_level_lib_target='//App:ExampleAppLibrary' xcworkspace='App/ExampleAppBuckLocal-BUCK.xcworkspace'
	open App/ExampleAppBuckLocal-BUCK.xcworkspace

dependency_graph:
	$(BUCK) query "deps(//App:ExampleAppBinary)" --dot > result.dot &&  dot result.dot -Tpng -o result.png && open result.png
