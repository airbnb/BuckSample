# BuckSample
This is a sample to show how to use buck to build mixed languages iOS project.

We make some local changes on top of Buck itself, you can find our own branch here
https://github.com/airbnb/buck/tree/airbnb_ios_current

To explain how are we use Buck, we setup this repo as a demo.

1. https://github.com/zayhero/BuckSample/blob/master/Pods/BUCK gives a few example about how are we build CocoaPods with Buck
2. https://github.com/zayhero/BuckSample/tree/master/src/ImportObjC/BUCK shows how to config mixed languages build rule
3. https://github.com/zayhero/BuckSample/blob/master/src/ImportFromAnotherLibrary/BUCK shows how to import from another mixed languages build rule
4. https://github.com/zayhero/BuckSample/blob/master/Test/BUCK is the main build file which shows how are we setup resource / assets and build the final binary / ipa file.

Should you have any question, feel free to leave comment / issue, or ping Brian (@zayhero) via Slack Buck Build channel https://buckbuild.slack.com.
