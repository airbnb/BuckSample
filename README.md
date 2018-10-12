# BuckSample
This is a sample to show how to use Buck to build an iOS project with mixed languages (Swift & Objective C).

To explain how we use Buck, we have setup this repo as a demo.

[![Build Status](https://travis-ci.com/airbnb/BuckSample.svg?branch=master)](https://travis-ci.com/airbnb/BuckSample)

### Instructions

```sh
brew install buck
buck targets
```

<img src="https://github.com/airbnb/BuckSample/raw/master/Docs/BuckTargets.png" width=500 />


### References
1. https://github.com/airbnb/BuckSample/blob/master/Pods/BUCK gives a few examples on how we build CocoaPods with Buck
2. https://github.com/airbnb/BuckSample/tree/master/src/ImportObjC/BUCK shows how to config a mixed languages build rule
3. https://github.com/airbnb/BuckSample/blob/master/src/ImportFromAnotherLibrary/BUCK shows how to import from another mixed languages build rule
4. https://github.com/airbnb/BuckSample/blob/master/Test/BUCK is the main build file which shows how we setup resources / assets and build the final binary / ipa file.

Should you have any questions, feel free to leave a comment, open an issue, or ping Brian (@zayhero) via Slack - Buck Build channel https://buckbuild.slack.com.

**Notice**
1. It's not a guarantee this project can build inside Xcode. The Xcode project config is created to make CocoaPods run correctly.
2. It's not guarantee the app binary can run smoothly in a simulator / device.
3. We are working on using `buck project` to generate Xcode project files, will update later.
