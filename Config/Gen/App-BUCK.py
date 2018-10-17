# App/BUCK

apple_asset_catalog(
  name = "ExampleAppAssets",
  app_icon = "AppIcon",
  dirs = [
    "Assets.xcassets",
  ],
  visibility = [
    "PUBLIC",
  ],
)

apple_binary(
  name = "ExampleAppBinary",
  configs = {
    "Debug": {
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
      "DEVELOPMENT_LANGUAGE": "Swift",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.ExampleApp",
    },
    "Profile": {
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
      "DEVELOPMENT_LANGUAGE": "Swift",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.ExampleApp",
    },
    "Release": {
      "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
      "DEVELOPMENT_LANGUAGE": "Swift",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.ExampleApp",
    },
  },
  srcs = [
    "main.m",
  ],
  swift_version = "4.2",
  deps = [
    ":ExampleAppLibrary",
    ":ExampleAppResource",
    ":ExampleAppAssets",
  ],
  visibility = [
    "PUBLIC",
  ],
)

apple_bundle(
  name = "ExampleAppBundle",
  binary = ":ExampleAppBinary",
  extension = "app",
  info_plist = "Info.plist",
  info_plist_substitutions = {
    "DEVELOPMENT_LANGUAGE": "en-us",
    "EXECUTABLE_NAME": "ExampleApp",
    "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.ExampleApp",
    "PRODUCT_NAME": "ExampleApp",
  },
  product_name = "ExampleApp",
  visibility = [
    "PUBLIC",
  ],
)

apple_library(
  name = "ExampleAppLibrary",
  compiler_flags = [
    "-Werror",
  ],
  configs = {
    "Debug": {
      "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",
      "ONLY_ACTIVE_ARCH": "YES",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "IPHONEOS_DEPLOYMENT_TARGET": "10.0",
    },
    "Profile": {
      "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",
      "ONLY_ACTIVE_ARCH": "YES",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "IPHONEOS_DEPLOYMENT_TARGET": "10.0",
    },
    "Release": {
      "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",
      "ONLY_ACTIVE_ARCH": "YES",
      "SDKROOT": "iphoneos",
      "GCC_OPTIMIZATION_LEVEL": "0",
      "SWIFT_OPTIMIZATION_LEVEL": "-Onone",
      "IPHONEOS_DEPLOYMENT_TARGET": "10.0",
    },
  },
  modular = True,
  srcs = [
    "AppDelegate.swift",
    "ViewController.swift",
  ],
  swift_compiler_flags = [
    "-warnings-as-errors",
  ],
  swift_version = "4.2",
  tests = [
    "//App/Tests:Tests",
  ],
  deps = [
    "//Libraries/ImportObjC:ImportObjC",
  ],
  visibility = [
    "PUBLIC",
  ],
)

apple_package(
  name = "ExampleAppPackage",
  bundle = ":ExampleAppBundle",
)

apple_resource(
  name = "ExampleAppResource",
  files = [
    "Base.lproj/LaunchScreen.storyboard",
  ],
  visibility = [
    "PUBLIC",
  ],
)

xcode_workspace_config(
  name = "lib_workspace",
  src_target = ":ExampleAppLibrary",
)

xcode_workspace_config(
  name = "workspace",
  action_config_names = {
    "profile": "Profile",
  },
  additional_scheme_actions = {
    "Build": {
      "PRE_SCHEME_ACTIONS": [
        "echo \'Started\'",
      ],
      "POST_SCHEME_ACTIONS": [
        "echo \'Finished\'",
      ],
    },
  },
  extra_schemes = {
    "ExampleLibrary": ":lib_workspace",
  },
  extra_tests = [
    "//App/Tests:Tests",
  ],
  src_target = ":ExampleAppBundle",
  workspace_name = "ExampleApp",
)

