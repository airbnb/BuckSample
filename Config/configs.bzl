load("//Config:utils.bzl", "config_with_updated_linker_flags", "configs_with_config")

DEVELOPMENT_LANGUAGE = "en"

def pretty(dict, current = ""):
    current = "\n"
    indent = 0
    for key, value in dict.items():
        current = current + str(key) + ": "
        if type(value) == type({}):
            current = current + "\n"
            indent = 1
            for key2, value2 in value.items():
                current = current + "\t" * indent + str(key2)
                current = current + ": " + str(value2) + "\n"
        else:
            current = current + "\t" * (indent + 1) + str(value) + "\n"

    return current

SHARED_CONFIGS = {
    "IPHONEOS_DEPLOYMENT_TARGET": "11.0",  # common target version
    "SDKROOT": "iphoneos", # platform
    "GCC_OPTIMIZATION_LEVEL": "0",  # clang optimization
    "SWIFT_OPTIMIZATION_LEVEL": "-Onone",  # swiftc optimization
    "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",  # for build performance
    "ONLY_ACTIVE_ARCH": "YES",
    "LD_RUNPATH_SEARCH_PATHS": "@executable_path/Frameworks", # To allow source files in binary
}

# Adding `-all_load` to our binaries works around https://bugs.swift.org/browse/SR-6004. See the
# longer comment in `ViewController.swift` for more details.
ALL_LOAD_LINKER_FLAG = "-all_load"

def bundle_identifier(name):
    return "com.airbnb.%s" % name

def library_configs():
    lib_specific_config = {
        "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",

        # Setting SKIP_INSTALL to NO for static library configs would create
        # create a generic xcode archive which can not be uploaded the app store
        # https://developer.apple.com/library/archive/technotes/tn2215/_index.html
        "SKIP_INSTALL": "YES",
    }
    library_config = SHARED_CONFIGS + lib_specific_config
    configs = {
        "Debug": library_config,
        "Profile": library_config,
        "Release": lib_specific_config,
    }
    return configs

def app_binary_configs(name):
    binary_specific_config = {
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
        "DEVELOPMENT_LANGUAGE": DEVELOPMENT_LANGUAGE,
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
        "CODE_SIGN_ENTITLEMENTS": (name + ".entitlements"),
    }
    binary_config = SHARED_CONFIGS + binary_specific_config
    binary_config = config_with_updated_linker_flags(binary_config, ALL_LOAD_LINKER_FLAG)
    return configs_with_config(binary_config)

def test_configs(name):
    binary_specific_config = info_plist_substitutions(name)
    binary_config = SHARED_CONFIGS + binary_specific_config
    configs = {
        "Debug": binary_config,
        "Profile": binary_config,
    }
    return configs

def pod_library_configs():
    pod_configs = LIBRARY_CONFIGS
    pod_configs["GCC_TREAT_WARNINGS_AS_ERRORS"] = "YES"
    pod_library_configs = {
        "Debug": pod_configs,
        "Profile": pod_configs,
    }
    return pod_library_configs

def info_plist_substitutions(name):
    substitutions = {
        "DEVELOPMENT_LANGUAGE": DEVELOPMENT_LANGUAGE,
        "EXECUTABLE_NAME": name,
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
        "PRODUCT_NAME": name,
    }
    return substitutions

# TODO: Currently this macro is used for both the watch app and the watch extension. This macro
# should be split into two, one for each of those binaries, as the configurations are diverging.
# At the very least only the watch extension needs the `WK_APP_BUNDLE_IDENTIFIER` key/value pair,
# and only the watch app needs the `WK_COMPANION_APP_BUNDLE_IDENTIFIER` key value pair. I also
# wonder if some of these other configuration settings are only necessary for one binary or the
# other. I cannot verify any of this at the moment due to
# https://github.com/airbnb/BuckSample/issues/97.
def watch_binary_configs(name):
    config = {
        "SDKROOT": "watchos",
        "WATCHOS_DEPLOYMENT_TARGET": "4.0",
        "TARGETED_DEVICE_FAMILY": "4",
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
        "LD_RUNPATH_SEARCH_PATHS": "$(inherited) @executable_path/Frameworks @executable_path/../../Frameworks",
        "WK_COMPANION_APP_BUNDLE_IDENTIFIER": bundle_identifier("ExampleApp"),
        "WK_APP_BUNDLE_IDENTIFIER": bundle_identifier("ExampleApp.WatchApp"),
        # Not sure why, but either adding this or removing -whole-module-optimization can make it compile
        "SWIFT_COMPILATION_MODE": "wholemodule",
    }
    config = config_with_updated_linker_flags(config, ALL_LOAD_LINKER_FLAG)
    return configs_with_config(config)

def message_binary_configs(name):
    config = {
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
        "SWIFT_COMPILATION_MODE": "wholemodule"
    }
    config = config_with_updated_linker_flags(config, ALL_LOAD_LINKER_FLAG)
    return configs_with_config(config)

def intent_binary_configs(info_plist_substitutions):
    config = {
        "SWIFT_COMPILATION_MODE": "wholemodule",
    }
    config.update(info_plist_substitutions)
    config = config_with_updated_linker_flags(config, ALL_LOAD_LINKER_FLAG)
    return configs_with_config(config)
