load("//Config:configs.bzl", "test_configs", "library_configs", "pod_library_configs")

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

def apple_test_lib(
        name,
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
            visibility = ["PUBLIC"],
            frameworks = [
                "$PLATFORM_DIR/Developer/Library/Frameworks/XCTest.framework",
            ] + frameworks,
            labels = ["CI"] + labels,
            **kwargs
        )

    substitutions = {
        "CURRENT_PROJECT_VERSION": "1",
        "DEVELOPMENT_LANGUAGE": "en-us",
        "EXECUTABLE_NAME": name,
        "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.%s" % test_name,
        "PRODUCT_NAME": name,
    }
    substitutions.update(info_plist_substitutions)
    native.apple_test(
        name = name,
        visibility = ["PUBLIC"],
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

def apple_test_all(
        libraries = [],
        additional_tests = [],
        **kwargs):
    ci_test_libraries = []
    for library in libraries:
        ci_test_libraries.append(ci_test_name(test_name(library)))

    apple_test_lib(
        deps = ci_test_libraries + additional_tests,
        **kwargs
    )

def apple_lib(
        name,
        swift_version = "4",
        modular = True,
        compiler_flags = None,
        swift_compiler_flags = None,
        warning_as_error = True,
        suppress_warnings = False,
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
        swift_version = swift_version,
        visibility = ["PUBLIC"],
        configs = library_configs(),
        modular = modular,
        compiler_flags = compiler_flags,
        swift_compiler_flags = swift_compiler_flags,
        **kwargs
    )

def first_party_library(
        name,
        has_objective_c = False,
        internal_headers = None,
        extra_xcode_files = [],
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
        srcs = sources,
        exported_headers = exported_headers,
        headers = internal_headers,
        modular = modular,
        compiler_flags = compiler_flags,
        swift_compiler_flags = swift_compiler_flags,
        extra_xcode_files = extra_xcode_files,
        deps = deps,
        frameworks = frameworks,
        tests = [":" + lib_test_name],
        **kwargs
    )
    
    test_sources = native.glob(["Tests/**/*.swift"])
    test_headers = None
    if has_objective_c:
        test_sources.extend(native.glob(["Tests/**/*.m"]))
        test_headers = native.glob(["Tests/**/*.h"])
    
    apple_test_lib(
        lib_test_name,
        srcs = test_sources,
        headers = test_headers,
        info_plist = info_plist,
        info_plist_substitutions = info_plist_substitutions,
        test_host_app = test_host_app,
        run_test_separately = run_test_separately,
        frameworks = test_frameworks,
        deps = [":" + name] + test_deps,
        **kwargs)

CXX_SRC_EXT = ["mm", "cpp", "S"]
def apple_cxx_lib(
        srcs = [],
        additional_external_linker_flags = [],
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
        ] + additional_external_linker_flags,
        **kwargs
    )

def apple_cxx_third_party_library(
        **kwargs):
    apple_cxx_lib(
        warning_as_error = False,
        suppress_warnings = True,
        **kwargs
    )
