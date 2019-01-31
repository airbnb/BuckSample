load("//Config:configs.bzl", "binary_configs", "library_configs", "pod_library_configs")

# This is just a regular lib that was warnings not set to error
def apple_third_party_lib(**kwargs):
    apple_lib(
        warning_as_error = False,
        suppress_warnings = True,
        **kwargs
    )

def apple_test_lib(name, **kwargs):
    substitutions = {
        "CURRENT_PROJECT_VERSION": "1",
        "DEVELOPMENT_LANGUAGE": "en-us",
        "PRODUCT_BUNDLE_IDENTIFIER": "com.company.%s" % name,
    }
    native.apple_test(
        name = name,
        info_plist_substitutions = substitutions,
        visibility = ["PUBLIC"],
        configs = library_configs(),
        frameworks = [
          "$PLATFORM_DIR/Developer/Library/Frameworks/XCTest.framework"
          ],
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
