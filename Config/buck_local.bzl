def buck_local_binary(
        name,
        native_xcode_deps = [],
        buck_local_deps = [],
        native_xcode_extra_files = [],
        buck_local_extra_files = [],
        tests = [],
        **kwargs):
    native.apple_binary(
        name = name,
        deps = native_xcode_deps,
        extra_xcode_files = native_xcode_extra_files,
        tests = tests,
        **kwargs
    )

    native.apple_binary(
        name = name + "BuckLocal",
        deps = buck_local_deps,
        extra_xcode_files = buck_local_extra_files,
        linker_flags = ["-exported_symbols_list", "/dev/null"],
        tests = [],
        **kwargs
    )

def buck_local_bundle(
        name,
        binary,
        native_xcode_deps = [],
        buck_local_deps = [],
        **kwargs):
    native.apple_bundle(
        name = name,
        binary = binary,
        deps = native_xcode_deps,
        **kwargs
    )

    native.apple_bundle(
        name = name + "BuckLocal",
        binary = binary + "BuckLocal",
        deps = buck_local_deps,
        **kwargs
    )

def buck_local_workspace(
        name,
        workspace_name,
        src_target,
        ui_test_target,
        native_xcode_scheme_actions = {},
        buck_local_scheme_actions = {},
        native_xcode_extra_schemes = {},
        **kwargs):
    native.xcode_workspace_config(
        name = name,
        workspace_name = workspace_name,
        src_target = src_target,
        # Since `ui_tests` require a different test runner in CLI, but can be launched as-is from Xcode, we will place them as `extra_tests` on the Xcode workspace - where they make the most semantic sense.
        extra_tests = [ui_test_target],
        extra_schemes = native_xcode_extra_schemes,
        additional_scheme_actions = native_xcode_scheme_actions,
        **kwargs
    )

    native.xcode_workspace_config(
        name = name + "-buck-local",
        workspace_name = workspace_name + "BuckLocal",
        src_target = src_target + "BuckLocal",
        extra_tests = [ui_test_target + "BuckLocal"],
        additional_scheme_actions = buck_local_scheme_actions,
        **kwargs
    )


def buck_local_apple_resource(
        visibility=[],
        **kwargs):
    native.apple_resource(
        visibility=visibility + ["//BuckLocal:"],
        **kwargs
    )

def buck_local_apple_asset_catalog(
        visibility=[],
        **kwargs):
    native.apple_asset_catalog(
        visibility=visibility + ["//BuckLocal:"],
        **kwargs
    )
