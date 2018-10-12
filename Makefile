
.PHONY : log install_buck build targets pods audit debug test

BUCK=tools/buck.pex

log:
	echo "Make"

install_buck: 
    curl https://jitpack.io/com/github/airbnb/buck/b652367c2b017ddce7fc0f94cb62ef6fd4138cf0/buck-b652367c2b017ddce7fc0f94cb62ef6fd4138cf0.pex --output "$BUCK"
	chmod u+x "$(BUCK)"

build:
	"$(BUCK)" build //Test:Test

debug:
	"$(BUCK)" install //Test:TestApp --run

targets:
	"$(BUCK)" targets //...

test:
	$(BUCK) test //Test:AppTests

ui_test:
	$(BUCK) test //Test:UITests -v 3

pods:
	"$(BUCK)" build //Pods:PromiseKit
	"$(BUCK)" build //Pods:Braintree
	"$(BUCK)" build //Pods:Nimble

audit:
	tools/buck.pex audit rules Pods/BUCK
