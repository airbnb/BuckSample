# BuckSample
This is a sample to show how to use Buck to build an iOS project with mixed languages (Swift & Objective C) at Airbnb.

[![Build Status](https://travis-ci.com/airbnb/BuckSample.svg?branch=master)](https://travis-ci.com/airbnb/BuckSample)

### To Install

```sh
# Install Buck
brew tap facebook/fb
brew install buck
```

### Running Tests
Press `Cmd + U` to run the unit tests for the `ExampleApp` target inside Xcode.

Or, from the terminal you can run `make test`.

<img src="https://github.com/airbnb/BuckSample/raw/master/Docs/CommandLineTests.png" width=500 />

### Viewing Targets
You may run `make targets` to see a list of Buck targets available to build/test/etc.

<img src="https://github.com/airbnb/BuckSample/raw/master/Docs/BuckTargets.png" width=450 />

### Viewing Dependencies
You may run `buck query "deps(//App:ExampleAppBinary)" --dot > result.dot` to save Graphviz output of the dependency tree starting at the rule `//App:ExampleAppBinary`. You may then run `dot -Tpng result.dot -o result.png` to create a PNG image showing this dependency structure.

<img src="https://github.com/airbnb/BuckSample/raw/master/Docs/DependencyGraph.png" />

### Generating an Xcode Project
To generate the project from the terminal, just run `make project`. You can then run in the simulator or press `Cmd + U` to run the tests.

You may also use breakpoints, just like normal when using the generated Xcode project.

<img src="https://github.com/airbnb/BuckSample/raw/master/Docs/Breakpoint.png" width=500 />


### References
1. https://github.com/airbnb/BuckSample/blob/master/Pods/BUCK gives a few examples on how we build CocoaPods with Buck
4. https://github.com/airbnb/BuckSample/blob/master/App/BUCK is the main build file which shows how we setup resources/assets and build the final binary/ipa file.

Buck Build channel https://buckbuild.slack.com.
