load("//Config:configs.bzl", "test_configs", "library_configs", "framework_configs", "pod_library_configs")

# This is just a regular lib that was warnings not set to error
def apple_third_party_lib(**kwargs):
    apple_lib(
        warning_as_error = False,
        suppress_warnings = True,
        **kwargs
    )

def test_name(name):
     return name + "Tests"
def ci_test_name(name):
    return name + "-For-CI"

DEFAULT_SWIFT_VERSION = "4.0"

def shared_plist_info_substitutions(name):
    substitutions = {
        "CURRENT_PROJECT_VERSION": "1",
        "DEVELOPMENT_LANGUAGE": "en-us",
        "EXECUTABLE_NAME": name,
        "PRODUCT_NAME": name,
    }
    return substitutions

# Use this macro to declare test targets. For first-party libraries, use first_party_library to declare a test target instead.
# This macro defines two targets.
# 1. An apple_test target comprising `srcs`. This test target is picked up by Xcode, and is runnable from Buck.
# 2. An apple_library target comprising the code in `srcs`. This library is used by the apple_test_all macro to create a single apple_test target in CI. This library will not be included in Xcode, unless an Xcode project is generated that relies on an apple_test_all target.
def apple_test_lib(
        name,
        visibility = ["PUBLIC"],
        bundle_for_ci = True,
        info_plist = None,
        info_plist_substitutions = {},
        test_host_app = None,
        run_test_separately = False,
        frameworks = [],
        labels = [],
        **kwargs):
    test_name = name + ".test"

    if bundle_for_ci:
        # Create a library with the test files. We'll use use these for our CI tests.
        # Libraries are much faster to create in CI than unit test bundles.
        # Therefore, we package up this test target as a library that we can depend on
        # later with a single apple_test bundle.
        native.apple_library(
            name = ci_test_name(name),
            visibility = visibility,
            frameworks = [
                "$PLATFORM_DIR/Developer/Library/Frameworks/XCTest.framework",
            ] + frameworks,
            labels = ["CI"] + labels,
            **kwargs
        )

    substitutions = shared_plist_info_substitutions(name)
    substitutions.update(info_plist_substitutions)
    substitutions.update({"PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.%s" % test_name})
    native.apple_test(
        name = name,
        visibility = visibility,
        info_plist = info_plist,
        info_plist_substitutions = substitutions,
        test_host_app = test_host_app,
        run_test_separately = run_test_separately,
        configs = test_configs(test_name),
        frameworks = [
          "$PLATFORM_DIR/Developer/Library/Frameworks/XCTest.framework"
        ] + frameworks,
        labels = labels,
        **kwargs
    )

# This macro bundles unit test libraries created by first_party_library or apple_test_lib into a single test target.
# Test targets can be slow to create in CI; creating only one can save significant time.
# - parameter libraries: The libraries whose tests should be put into the single test target.
# - parameter additional_tests: Additional apple_test targets that should be run as part of the single test target.
def apple_test_all(
        libraries = [],
        additional_tests = [],
        **kwargs):
    ci_test_libraries = []
    for library in libraries:
        ci_test_libraries.append(ci_test_name(test_name(library)))

    apple_test_lib(
        deps = ci_test_libraries + additional_tests,
        bundle_for_ci = False,
        **kwargs
    )

def apple_lib(
        name,
        visibility = ["PUBLIC"],
        swift_version = DEFAULT_SWIFT_VERSION,
        modular = True,
        compiler_flags = None,
        swift_compiler_flags = None,
        warning_as_error = True,
        suppress_warnings = False,
        configs = library_configs(),
        **kwargs):
    compiler_flags = compiler_flags or []
    swift_compiler_flags = swift_compiler_flags or []

    # Don't treat warnings as errors for Beta Xcode versions
    if native.read_config("xcode", "beta") == "True":
        warning_as_error = False

    if warning_as_error:
        compiler_flags.append("-Werror")
        swift_compiler_flags.append("-warnings-as-errors")
    elif suppress_warnings:
        compiler_flags.append("-w")
        swift_compiler_flags.append("-suppress-warnings")

    native.apple_library(
        name = name,
        visibility = visibility,
        swift_version = swift_version,
        configs = configs,
        modular = modular,
        compiler_flags = compiler_flags,
        swift_compiler_flags = swift_compiler_flags,
        **kwargs
    )

# Use this macro to declare first-party libraries.
# First-party must have their source in /Sources, and test code in /Tests
# This macro defines three targets.
# 1. An apple_library target comprising the code in the Sources/ directory. This library target is used by both Xcode and Buck.
# 2. An apple_test target comprising the test code in the Tests/ directory. This test target is picked up by Xcode, and is runnable from Buck.
# 3. An apple_library target comprising the code in the Tests/ directory. This library is used by the apple_test_all macro to create a single apple_test target in CI. This library will not be included in Xcode, unless an Xcode project is generated that relies on an apple_test_all target.
# - parameter name: The name of the apple_library created for the code in the Sources/ directory.
# - parameter has_objective_c: When set to True, the libraries and tests will look for Objective-C headers and files.
# - parameter internal_headers: An array of Objective-C headers that should be included in the library target, but should not be exported.
# - parameter mlmodel_generated_source: A list of generated interface source files for mlmodels.
# - parameter warning_as_error: When set to True, the source library created will not compile when warnings are present.
# - parameter suppress_warnings: When set to True, the source library created will not show any warnings, even if warnings exist.
def first_party_library(
        name,
        has_objective_c = False,
        internal_headers = None,
        extra_xcode_files = [],
        mlmodel_generated_source = [],
        deps = [],
        frameworks = [],
        info_plist = "Tests/Info.plist",
        info_plist_substitutions = {},
        test_host_app = None,
        run_test_separately = False,
        test_frameworks = [],
        test_deps = [],
        modular = True,
        compiler_flags = None,
        swift_compiler_flags = None,
        warning_as_error = True,
        suppress_warnings = False,
        **kwargs):
    sources = native.glob(["Sources/**/*.swift"])
    exported_headers = None
    if has_objective_c:
        sources.extend(native.glob(["Sources/**/*.m"]))
        exported_headers = []
        all_headers = native.glob(["Sources/**/*.h"])
        for header in all_headers:
            if not header in (internal_headers or []):
                exported_headers.append(header)

    lib_test_name = test_name(name)
    apple_lib(
        name = name,
        srcs = sources + mlmodel_generated_source,
        exported_headers = exported_headers,
        headers = internal_headers,
        modular = modular,
        compiler_flags = compiler_flags,
        swift_compiler_flags = swift_compiler_flags,
        extra_xcode_files = extra_xcode_files,
        deps = deps,
        frameworks = frameworks,
        tests = [":" + lib_test_name],
        warning_as_error = warning_as_error,
        suppress_warnings = suppress_warnings,
        **kwargs
    )
    
    test_sources = native.glob(["Tests/**/*.swift"])
    test_headers = None
    if has_objective_c:
        test_sources.extend(native.glob(["Tests/**/*.m"]))
        test_headers = native.glob(["Tests/**/*.h"])
    
    apple_test_lib(
        name = lib_test_name,
        srcs = test_sources,
        headers = test_headers,
        info_plist = info_plist,
        info_plist_substitutions = info_plist_substitutions,
        test_host_app = test_host_app,
        run_test_separately = run_test_separately,
        frameworks = test_frameworks,
        deps = [":" + name] + test_deps,
        **kwargs)

# Use this macro to declare first-party frameworks (dylib and resource) which can be shared between bundles.
# This macro is similar to first_party_library, and we can support more parameters in the future.
# - parameter name: The name of the apple_library created for the code in the Sources/ directory. The name will become the module name.
# - parameter exported_headers: The public headers for the library
def first_party_framework(
        name,
        exported_headers = [],
        deps = [],
        has_resource = False,
        resource_files = None):
    framework_name = "%sFramework" % name
    resource_name = "%sResource" % name
    lib_test_name = test_name(name)

    apple_lib(
        name, 
        srcs = native.glob(["Sources/**/*.swift"]),
        exported_headers = exported_headers,
        configs = framework_configs(framework_name),
        # Setting preferred_linkage to shared is the key to make a dylib. 
        preferred_linkage = "shared",
        # Set the install_name so consumers of this dylib know where to find it.
        linker_flags = ["-Wl,-install_name,@rpath/%s.framework/%s" % (name, name)],
        deps = deps + ([":" + resource_name] if has_resource else []),
        tests = [":" + lib_test_name],
    )

    substitutions = shared_plist_info_substitutions(name)
    substitutions.update({"PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.%s" % framework_name})
    native.apple_bundle(
        name = framework_name,
        product_name = name,
        binary = ":%s#shared" % name,
        extension = "framework",
        info_plist = "Info.plist",
        info_plist_substitutions = substitutions,
        xcode_product_type = "com.apple.product-type.framework",
        visibility = ["PUBLIC"],
    )

    apple_test_lib(
        name = lib_test_name,
        srcs = native.glob(["Tests/**/*.swift"]),
        info_plist = "Tests/Info.plist",
        deps = [
            ":" + name,
            ":" + framework_name,
        ],
    )

    if has_resource:
        native.apple_resource(
            name = resource_name,
            visibility = ["PUBLIC"],
            files = resource_files,
            dirs = [],
        )

CXX_SRC_EXT = ["mm", "cpp", "S"]
def apple_cxx_lib(
        srcs = [],
        additional_exported_linker_flags = [],
        **kwargs):
    c_srcs, cxx_srcs = [], []

    cxx_compile_flags = native.read_config("cxx", "cxxflags").split(" ")
    cxx_compile_flags.append("-w")

    for file_ in srcs:
        if file_.split(".")[-1] in CXX_SRC_EXT:
            cxx_srcs.append((file_, cxx_compile_flags))
        else:
            c_srcs.append(file_)
    apple_lib(
        srcs = c_srcs + cxx_srcs,
        exported_linker_flags = [
            "-lc++",
            "-lz"
        ] + additional_exported_linker_flags,
        **kwargs
    )

def apple_cxx_third_party_library(
        **kwargs):
    apple_cxx_lib(
        warning_as_error = False,
        suppress_warnings = True,
        **kwargs
    )

def logging_genrule(
        name,
        bash,
        **kwargs):
    native.genrule(
        name = name,
        bash = "set -x; " + bash,
        **kwargs
    )

# Takes in a .mlmodel and produces a Swift interface and a compiled .mlmodelc.
# - parameter resource_source_name: The expected name of the Swift interface to be included in `srcs`.
# - parameter resource_dependency_name: The expected name of the resource to add to `deps`.
# - parameter model_directory: The relative path to folder where the .mlmodel lives. Must include a trailing slash.
# - parameter model_name: The name of the .mlmodel. Do not include the .mlmodel suffix.
# - parameter swift_version: The expected Swift version for the generated Swift interface file.
def mlmodel_resource(
        resource_source_name,
        resource_dependency_name,
        model_directory,
        model_name,
        swift_version = DEFAULT_SWIFT_VERSION):
    # Create a genrule to compile the Swift interface for the mlmodel to be included in srcs.
    # For more information about generated Swift interfaces, see Apple's documentation:
    # https://developer.apple.com/documentation/coreml/mlmodel
    logging_genrule(
        name = resource_source_name,
        srcs = [model_directory + model_name + ".mlmodel"],
        bash = 'xcrun coremlc generate "$SRCS" "\$(dirname "$OUT")" --language Swift --swift-version ' + swift_version,
        out = "%s.swift" % model_name,
    )

    modelc_resource = resource_dependency_name + "_compiled_model"
    # Create a genrule to compile the mlmodelc from the mlmodel.
    logging_genrule(
        name = modelc_resource,
        srcs = [model_directory + model_name + ".mlmodel"],
        bash = 'xcrun coremlc compile "$SRCS" "\$(dirname "$OUT")"',
        out = "%s.mlmodelc" % model_name,
    )

    # Create a single resource that can be depended on for the mlmodelc.
    native.apple_resource(
        name = resource_dependency_name,
        dirs = [
            ":" + modelc_resource,
        ],
        files = [],
    )
