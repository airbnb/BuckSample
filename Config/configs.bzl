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
    "IPHONEOS_DEPLOYMENT_TARGET": "10.0",  # common target version
    "SDKROOT": "iphoneos", # platform
    "GCC_OPTIMIZATION_LEVEL": "0",  # clang optimization
    "SWIFT_OPTIMIZATION_LEVEL": "-Onone",  # swiftc optimization
    "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",  # for build performance
    "ONLY_ACTIVE_ARCH": "YES",
    "LD_RUNPATH_SEARCH_PATHS": "@executable_path/Frameworks", # To allow source files in binary
}

def bundle_identifier(name):
    return "com.airbnb.%s" % name

def library_configs():
    lib_specific_config = {
        "SWIFT_WHOLE_MODULE_OPTIMIZATION": "YES",

        # Setting SKIP_INSTALL to NO for library configs would create
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

def binary_configs(name):
    binary_specific_config = {
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
        "DEVELOPMENT_LANGUAGE": "Swift",
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
    }
    binary_config = SHARED_CONFIGS + binary_specific_config
    configs = {
        "Debug": binary_config,
        "Profile": binary_config,
    }
    return configs

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
        "DEVELOPMENT_LANGUAGE": "en-us",
        "EXECUTABLE_NAME": name,
        "PRODUCT_BUNDLE_IDENTIFIER": bundle_identifier(name),
        "PRODUCT_NAME": name,
    }
    return substitutions
