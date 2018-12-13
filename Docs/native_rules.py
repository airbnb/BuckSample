from buck_parser.buck import *

@provide_as_native_rule
def kotlin_library(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, exported_deps=None, extra_arguments=None, extra_kotlinc_arguments=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'kotlin_library',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraKotlincArguments': extra_kotlinc_arguments,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def kotlin_test(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, contacts=None, cxx_library_whitelist=None, default_cxx_platform=None, deps=None, env=None, exported_deps=None, extra_arguments=None, extra_kotlinc_arguments=None, fork_mode=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, run_test_separately=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, std_err_log_level=None, std_out_log_level=None, target=None, test_case_timeout_ms=None, test_rule_timeout_ms=None, test_type=None, tests=None, unbundled_resources_root=None, use_cxx_libraries=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'kotlin_test',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'contacts': contacts,
        'cxxLibraryWhitelist': cxx_library_whitelist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'env': env,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraKotlincArguments': extra_kotlinc_arguments,
        'forkMode': fork_mode,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'runTestSeparately': run_test_separately,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'stdErrLogLevel': std_err_log_level,
        'stdOutLogLevel': std_out_log_level,
        'target': target,
        'testCaseTimeoutMs': test_case_timeout_ms,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'testType': test_type,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'useCxxLibraries': use_cxx_libraries,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_jar(name, binary_jar, deps=None, gwt_jar=None, javadoc_url=None, labels=None, licenses=None, maven_coords=None, provided=None, required_for_source_only_abi=None, source_jar=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_jar',
        'name': name,
        'binaryJar': binary_jar,
        'deps': deps,
        'gwtJar': gwt_jar,
        'javadocUrl': javadoc_url,
        'labels': labels,
        'licenses': licenses,
        'mavenCoords': maven_coords,
        'provided': provided,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'sourceJar': source_jar,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def zip_file(name, deps=None, flatten=None, labels=None, licenses=None, merge_source_zips=None, out=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'zip_file',
        'name': name,
        'deps': deps,
        'flatten': flatten,
        'labels': labels,
        'licenses': licenses,
        'mergeSourceZips': merge_source_zips,
        'out': out,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def graphql_library(name, deps=None, labels=None, licenses=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'graphql_library',
        'name': name,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def python_binary(name, base_module=None, build_args=None, cxx_platform=None, deps=None, extension=None, labels=None, licenses=None, linker_flags=None, main=None, main_module=None, package_style=None, platform=None, platform_deps=None, preload_deps=None, tests=None, version_universe=None, zip_safe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'python_binary',
        'name': name,
        'baseModule': base_module,
        'buildArgs': build_args,
        'cxxPlatform': cxx_platform,
        'deps': deps,
        'extension': extension,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'main': main,
        'mainModule': main_module,
        'packageStyle': package_style,
        'platform': platform,
        'platformDeps': platform_deps,
        'preloadDeps': preload_deps,
        'tests': tests,
        'versionUniverse': version_universe,
        'zipSafe': zip_safe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_python_library(name, binary_src, deps=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_python_library',
        'name': name,
        'binarySrc': binary_src,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def python_library(name, base_module=None, deps=None, labels=None, licenses=None, platform_deps=None, platform_resources=None, platform_srcs=None, resources=None, srcs=None, tests=None, versioned_resources=None, versioned_srcs=None, zip_safe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'python_library',
        'name': name,
        'baseModule': base_module,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'platformDeps': platform_deps,
        'platformResources': platform_resources,
        'platformSrcs': platform_srcs,
        'resources': resources,
        'srcs': srcs,
        'tests': tests,
        'versionedResources': versioned_resources,
        'versionedSrcs': versioned_srcs,
        'zipSafe': zip_safe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def python_test(name, base_module=None, build_args=None, contacts=None, cxx_platform=None, deps=None, env=None, extension=None, labels=None, licenses=None, linker_flags=None, main_module=None, needed_coverage=None, package_style=None, platform=None, platform_deps=None, platform_resources=None, platform_srcs=None, preload_deps=None, resources=None, srcs=None, test_rule_timeout_ms=None, tests=None, version_universe=None, versioned_resources=None, versioned_srcs=None, zip_safe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'python_test',
        'name': name,
        'baseModule': base_module,
        'buildArgs': build_args,
        'contacts': contacts,
        'cxxPlatform': cxx_platform,
        'deps': deps,
        'env': env,
        'extension': extension,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'mainModule': main_module,
        'neededCoverage': needed_coverage,
        'packageStyle': package_style,
        'platform': platform,
        'platformDeps': platform_deps,
        'platformResources': platform_resources,
        'platformSrcs': platform_srcs,
        'preloadDeps': preload_deps,
        'resources': resources,
        'srcs': srcs,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'tests': tests,
        'versionUniverse': version_universe,
        'versionedResources': versioned_resources,
        'versionedSrcs': versioned_srcs,
        'zipSafe': zip_safe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_python_extension(name, base_module=None, compiler_flags=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, linker_extra_outputs=None, linker_flags=None, module_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_python_extension',
        'name': name,
        'baseModule': base_module,
        'compilerFlags': compiler_flags,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'moduleName': module_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_aar(name, manifest_skeleton, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, build_config_values=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, deps_query=None, exported_deps=None, extra_arguments=None, extra_kotlinc_arguments=None, final_r_name=None, include_build_config_class=None, java_version=None, javac=None, javac_jar=None, labels=None, language=None, licenses=None, manifest=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, provided_deps_query=None, remove_classes=None, required_for_source_only_abi=None, resource_union_package=None, resources=None, resources_root=None, skip_non_union_r_dot_java=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_aar',
        'name': name,
        'manifestSkeleton': manifest_skeleton,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'buildConfigValues': build_config_values,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'depsQuery': deps_query,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraKotlincArguments': extra_kotlinc_arguments,
        'finalRName': final_r_name,
        'includeBuildConfigClass': include_build_config_class,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'language': language,
        'licenses': licenses,
        'manifest': manifest,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'providedDepsQuery': provided_deps_query,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resourceUnionPackage': resource_union_package,
        'resources': resources,
        'resourcesRoot': resources_root,
        'skipNonUnionRDotJava': skip_non_union_r_dot_java,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_manifest(name, skeleton, deps=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_manifest',
        'name': name,
        'skeleton': skeleton,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_app_modularity(name, application_module_configs=None, deps=None, labels=None, licenses=None, no_dx=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_app_modularity',
        'name': name,
        'applicationModuleConfigs': application_module_configs,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'noDx': no_dx,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_binary(name, keystore, aapt_mode=None, allowed_duplicate_resource_types=None, android_app_modularity_result=None, android_sdk_proguard_config=None, application_module_configs=None, application_module_targets=None, banned_duplicate_resource_types=None, build_config_values=None, build_config_values_file=None, build_string_source_map=None, compress_asset_libraries=None, cpu_filters=None, deps=None, dex_compression=None, dex_reorder_data_dump_file=None, dex_reorder_tool_file=None, dex_tool=None, disable_pre_dex=None, duplicate_resource_behavior=None, duplicate_resource_whitelist=None, enable_relinker=None, exopackage=None, exopackage_modes=None, ignore_aapt_proguard_config=None, includes_vector_drawables=None, is_cacheable=None, keep_resource_pattern=None, labels=None, licenses=None, linear_alloc_hard_limit=None, locales=None, manifest=None, manifest_entries=None, manifest_skeleton=None, minimize_primary_dex_size=None, native_library_merge_code_generator=None, native_library_merge_glue=None, native_library_merge_localized_symbols=None, native_library_merge_map=None, native_library_proguard_config_generator=None, no_auto_version_resources=None, no_dx=None, optimization_passes=None, package_asset_libraries=None, package_type=None, post_filter_resources_cmd=None, preprocess_java_classes_bash=None, preprocess_java_classes_deps=None, primary_dex_classes_file=None, primary_dex_patterns=None, primary_dex_scenario_file=None, primary_dex_scenario_overflow_allowed=None, proguard_config=None, proguard_jvm_args=None, redex=None, redex_config=None, redex_extra_args=None, relinker_whitelist=None, reorder_classes_intra_dex=None, resource_compression=None, resource_filter=None, resource_union_package=None, secondary_dex_head_classes_file=None, secondary_dex_tail_classes_file=None, skip_crunch_pngs=None, skip_proguard=None, tests=None, trim_resource_ids=None, use_split_dex=None, xz_compression_level=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_binary',
        'name': name,
        'keystore': keystore,
        'aaptMode': aapt_mode,
        'allowedDuplicateResourceTypes': allowed_duplicate_resource_types,
        'androidAppModularityResult': android_app_modularity_result,
        'androidSdkProguardConfig': android_sdk_proguard_config,
        'applicationModuleConfigs': application_module_configs,
        'applicationModuleTargets': application_module_targets,
        'bannedDuplicateResourceTypes': banned_duplicate_resource_types,
        'buildConfigValues': build_config_values,
        'buildConfigValuesFile': build_config_values_file,
        'buildStringSourceMap': build_string_source_map,
        'compressAssetLibraries': compress_asset_libraries,
        'cpuFilters': cpu_filters,
        'deps': deps,
        'dexCompression': dex_compression,
        'dexReorderDataDumpFile': dex_reorder_data_dump_file,
        'dexReorderToolFile': dex_reorder_tool_file,
        'dexTool': dex_tool,
        'disablePreDex': disable_pre_dex,
        'duplicateResourceBehavior': duplicate_resource_behavior,
        'duplicateResourceWhitelist': duplicate_resource_whitelist,
        'enableRelinker': enable_relinker,
        'exopackage': exopackage,
        'exopackageModes': exopackage_modes,
        'ignoreAaptProguardConfig': ignore_aapt_proguard_config,
        'includesVectorDrawables': includes_vector_drawables,
        'isCacheable': is_cacheable,
        'keepResourcePattern': keep_resource_pattern,
        'labels': labels,
        'licenses': licenses,
        'linearAllocHardLimit': linear_alloc_hard_limit,
        'locales': locales,
        'manifest': manifest,
        'manifestEntries': manifest_entries,
        'manifestSkeleton': manifest_skeleton,
        'minimizePrimaryDexSize': minimize_primary_dex_size,
        'nativeLibraryMergeCodeGenerator': native_library_merge_code_generator,
        'nativeLibraryMergeGlue': native_library_merge_glue,
        'nativeLibraryMergeLocalizedSymbols': native_library_merge_localized_symbols,
        'nativeLibraryMergeMap': native_library_merge_map,
        'nativeLibraryProguardConfigGenerator': native_library_proguard_config_generator,
        'noAutoVersionResources': no_auto_version_resources,
        'noDx': no_dx,
        'optimizationPasses': optimization_passes,
        'packageAssetLibraries': package_asset_libraries,
        'packageType': package_type,
        'postFilterResourcesCmd': post_filter_resources_cmd,
        'preprocessJavaClassesBash': preprocess_java_classes_bash,
        'preprocessJavaClassesDeps': preprocess_java_classes_deps,
        'primaryDexClassesFile': primary_dex_classes_file,
        'primaryDexPatterns': primary_dex_patterns,
        'primaryDexScenarioFile': primary_dex_scenario_file,
        'primaryDexScenarioOverflowAllowed': primary_dex_scenario_overflow_allowed,
        'proguardConfig': proguard_config,
        'proguardJvmArgs': proguard_jvm_args,
        'redex': redex,
        'redexConfig': redex_config,
        'redexExtraArgs': redex_extra_args,
        'relinkerWhitelist': relinker_whitelist,
        'reorderClassesIntraDex': reorder_classes_intra_dex,
        'resourceCompression': resource_compression,
        'resourceFilter': resource_filter,
        'resourceUnionPackage': resource_union_package,
        'secondaryDexHeadClassesFile': secondary_dex_head_classes_file,
        'secondaryDexTailClassesFile': secondary_dex_tail_classes_file,
        'skipCrunchPngs': skip_crunch_pngs,
        'skipProguard': skip_proguard,
        'tests': tests,
        'trimResourceIds': trim_resource_ids,
        'useSplitDex': use_split_dex,
        'xzCompressionLevel': xz_compression_level,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_build_config(name, package, labels=None, licenses=None, values=None, values_file=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_build_config',
        'name': name,
        'package': package,
        'labels': labels,
        'licenses': licenses,
        'values': values,
        'valuesFile': values_file,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_instrumentation_apk(name, apk, deps=None, dex_tool=None, includes_vector_drawables=None, labels=None, licenses=None, manifest=None, manifest_skeleton=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_instrumentation_apk',
        'name': name,
        'apk': apk,
        'deps': deps,
        'dexTool': dex_tool,
        'includesVectorDrawables': includes_vector_drawables,
        'labels': labels,
        'licenses': licenses,
        'manifest': manifest,
        'manifestSkeleton': manifest_skeleton,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_instrumentation_test(name, apk, contacts=None, labels=None, licenses=None, test_rule_timeout_ms=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_instrumentation_test',
        'name': name,
        'apk': apk,
        'contacts': contacts,
        'labels': labels,
        'licenses': licenses,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_library(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, deps_query=None, exported_deps=None, extra_arguments=None, extra_kotlinc_arguments=None, final_r_name=None, java_version=None, javac=None, javac_jar=None, labels=None, language=None, licenses=None, manifest=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, provided_deps_query=None, remove_classes=None, required_for_source_only_abi=None, resource_union_package=None, resources=None, resources_root=None, skip_non_union_r_dot_java=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_library',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'depsQuery': deps_query,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraKotlincArguments': extra_kotlinc_arguments,
        'finalRName': final_r_name,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'language': language,
        'licenses': licenses,
        'manifest': manifest,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'providedDepsQuery': provided_deps_query,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resourceUnionPackage': resource_union_package,
        'resources': resources,
        'resourcesRoot': resources_root,
        'skipNonUnionRDotJava': skip_non_union_r_dot_java,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_prebuilt_aar(name, aar, deps=None, javadoc_url=None, labels=None, licenses=None, required_for_source_only_abi=None, source_jar=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_prebuilt_aar',
        'name': name,
        'aar': aar,
        'deps': deps,
        'javadocUrl': javadoc_url,
        'labels': labels,
        'licenses': licenses,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'sourceJar': source_jar,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def android_resource(name, assets=None, deps=None, has_whitelisted_strings=None, labels=None, licenses=None, manifest=None, package=None, project_assets=None, project_res=None, res=None, resource_union=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'android_resource',
        'name': name,
        'assets': assets,
        'deps': deps,
        'hasWhitelistedStrings': has_whitelisted_strings,
        'labels': labels,
        'licenses': licenses,
        'manifest': manifest,
        'package': package,
        'projectAssets': project_assets,
        'projectRes': project_res,
        'res': res,
        'resourceUnion': resource_union,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def robolectric_test(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, contacts=None, cxx_library_whitelist=None, default_cxx_platform=None, deps=None, env=None, exported_deps=None, extra_arguments=None, extra_kotlinc_arguments=None, force_final_resource_ids=None, fork_mode=None, java_version=None, javac=None, javac_jar=None, labels=None, language=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resource_union_package=None, resources=None, resources_root=None, robolectric_manifest=None, robolectric_runtime_dependency=None, run_test_separately=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, std_err_log_level=None, std_out_log_level=None, target=None, test_case_timeout_ms=None, test_rule_timeout_ms=None, test_type=None, tests=None, unbundled_resources_root=None, use_cxx_libraries=None, use_old_styleable_format=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'robolectric_test',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'contacts': contacts,
        'cxxLibraryWhitelist': cxx_library_whitelist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'env': env,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraKotlincArguments': extra_kotlinc_arguments,
        'forceFinalResourceIds': force_final_resource_ids,
        'forkMode': fork_mode,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'language': language,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resourceUnionPackage': resource_union_package,
        'resources': resources,
        'resourcesRoot': resources_root,
        'robolectricManifest': robolectric_manifest,
        'robolectricRuntimeDependency': robolectric_runtime_dependency,
        'runTestSeparately': run_test_separately,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'stdErrLogLevel': std_err_log_level,
        'stdOutLogLevel': std_out_log_level,
        'target': target,
        'testCaseTimeoutMs': test_case_timeout_ms,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'testType': test_type,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'useCxxLibraries': use_cxx_libraries,
        'useOldStyleableFormat': use_old_styleable_format,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_native_library(name, native_libs, deps=None, is_asset=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_native_library',
        'name': name,
        'nativeLibs': native_libs,
        'deps': deps,
        'isAsset': is_asset,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def ndk_library(name, deps=None, flags=None, is_asset=None, labels=None, licenses=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'ndk_library',
        'name': name,
        'deps': deps,
        'flags': flags,
        'isAsset': is_asset,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def gen_aidl(name, aidl, import_path, deps=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'gen_aidl',
        'name': name,
        'aidl': aidl,
        'importPath': import_path,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apk_genrule(name, apk, bash=None, cmd=None, cmd_exe=None, enable_sandbox=None, environment_expansion_separator=None, is_cacheable=None, labels=None, licenses=None, out=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apk_genrule',
        'name': name,
        'apk': apk,
        'bash': bash,
        'cmd': cmd,
        'cmdExe': cmd_exe,
        'enableSandbox': enable_sandbox,
        'environmentExpansionSeparator': environment_expansion_separator,
        'isCacheable': is_cacheable,
        'labels': labels,
        'licenses': licenses,
        'out': out,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def halide_library(name, compiler_deps=None, compiler_flags=None, compiler_invocation_flags=None, configs=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, deps_query=None, frameworks=None, function_name=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_deps_query_whole=None, link_style=None, linker_extra_outputs=None, linker_flags=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, srcs=None, supported_platforms_regex=None, tests=None, thin_lto=None, version_universe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'halide_library',
        'name': name,
        'compilerDeps': compiler_deps,
        'compilerFlags': compiler_flags,
        'compilerInvocationFlags': compiler_invocation_flags,
        'configs': configs,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'depsQuery': deps_query,
        'frameworks': frameworks,
        'functionName': function_name,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkDepsQueryWhole': link_deps_query_whole,
        'linkStyle': link_style,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'srcs': srcs,
        'supportedPlatformsRegex': supported_platforms_regex,
        'tests': tests,
        'thinLto': thin_lto,
        'versionUniverse': version_universe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_binary(name, compiler_flags=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, deps_query=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_deps_query_whole=None, link_style=None, linker_extra_outputs=None, linker_flags=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, srcs=None, tests=None, thin_lto=None, version_universe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_binary',
        'name': name,
        'compilerFlags': compiler_flags,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'depsQuery': deps_query,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkDepsQueryWhole': link_deps_query_whole,
        'linkStyle': link_style,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'srcs': srcs,
        'tests': tests,
        'thinLto': thin_lto,
        'versionUniverse': version_universe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_library(name, bridging_header=None, can_be_asset=None, compiler_flags=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, exported_deps=None, exported_headers=None, exported_lang_preprocessor_flags=None, exported_linker_flags=None, exported_platform_deps=None, exported_platform_headers=None, exported_platform_linker_flags=None, exported_platform_preprocessor_flags=None, exported_preprocessor_flags=None, extra_xcode_files=None, extra_xcode_sources=None, force_static=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_style=None, link_whole=None, linker_extra_outputs=None, linker_flags=None, modular=None, module_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, preferred_linkage=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, reexport_all_header_dependencies=None, soname=None, srcs=None, static_library_basename=None, supported_platforms_regex=None, tests=None, thin_lto=None, xcode_private_headers_symlinks=None, xcode_public_headers_symlinks=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_library',
        'name': name,
        'bridgingHeader': bridging_header,
        'canBeAsset': can_be_asset,
        'compilerFlags': compiler_flags,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'exportedDeps': exported_deps,
        'exportedHeaders': exported_headers,
        'exportedLangPreprocessorFlags': exported_lang_preprocessor_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformDeps': exported_platform_deps,
        'exportedPlatformHeaders': exported_platform_headers,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'exportedPlatformPreprocessorFlags': exported_platform_preprocessor_flags,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'extraXcodeFiles': extra_xcode_files,
        'extraXcodeSources': extra_xcode_sources,
        'forceStatic': force_static,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkWhole': link_whole,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'modular': modular,
        'moduleName': module_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'preferredLinkage': preferred_linkage,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'reexportAllHeaderDependencies': reexport_all_header_dependencies,
        'soname': soname,
        'srcs': srcs,
        'staticLibraryBasename': static_library_basename,
        'supportedPlatformsRegex': supported_platforms_regex,
        'tests': tests,
        'thinLto': thin_lto,
        'xcodePrivateHeadersSymlinks': xcode_private_headers_symlinks,
        'xcodePublicHeadersSymlinks': xcode_public_headers_symlinks,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_genrule(name, out, bash=None, cmd=None, cmd_exe=None, enable_sandbox=None, environment_expansion_separator=None, labels=None, licenses=None, srcs=None, tests=None, type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_genrule',
        'name': name,
        'out': out,
        'bash': bash,
        'cmd': cmd,
        'cmdExe': cmd_exe,
        'enableSandbox': enable_sandbox,
        'environmentExpansionSeparator': environment_expansion_separator,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'tests': tests,
        'type': type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_test(name, additional_coverage_targets=None, args=None, compiler_flags=None, contacts=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, deps_query=None, env=None, framework=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_deps_query_whole=None, link_style=None, linker_extra_outputs=None, linker_flags=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, resources=None, run_test_separately=None, srcs=None, test_rule_timeout_ms=None, tests=None, thin_lto=None, use_default_test_main=None, version_universe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_test',
        'name': name,
        'additionalCoverageTargets': additional_coverage_targets,
        'args': args,
        'compilerFlags': compiler_flags,
        'contacts': contacts,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'depsQuery': deps_query,
        'env': env,
        'framework': framework,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkDepsQueryWhole': link_deps_query_whole,
        'linkStyle': link_style,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'resources': resources,
        'runTestSeparately': run_test_separately,
        'srcs': srcs,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'tests': tests,
        'thinLto': thin_lto,
        'useDefaultTestMain': use_default_test_main,
        'versionUniverse': version_universe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_cxx_library(name, can_be_asset=None, deps=None, exported_deps=None, exported_headers=None, exported_lang_preprocessor_flags=None, exported_linker_flags=None, exported_platform_headers=None, exported_platform_linker_flags=None, exported_platform_preprocessor_flags=None, exported_preprocessor_flags=None, force_static=None, frameworks=None, header_dirs=None, header_namespace=None, header_only=None, include_dirs=None, labels=None, lib_dir=None, lib_name=None, libraries=None, licenses=None, link_whole=None, link_without_soname=None, platform_header_dirs=None, platform_shared_lib=None, platform_static_lib=None, platform_static_pic_lib=None, preferred_linkage=None, provided=None, shared_lib=None, soname=None, static_lib=None, static_pic_lib=None, supported_platforms_regex=None, supports_merged_linking=None, supports_shared_library_interface=None, versioned_header_dirs=None, versioned_shared_lib=None, versioned_static_lib=None, versioned_static_pic_lib=None, versioned_sub_dir=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_cxx_library',
        'name': name,
        'canBeAsset': can_be_asset,
        'deps': deps,
        'exportedDeps': exported_deps,
        'exportedHeaders': exported_headers,
        'exportedLangPreprocessorFlags': exported_lang_preprocessor_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformHeaders': exported_platform_headers,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'exportedPlatformPreprocessorFlags': exported_platform_preprocessor_flags,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'forceStatic': force_static,
        'frameworks': frameworks,
        'headerDirs': header_dirs,
        'headerNamespace': header_namespace,
        'headerOnly': header_only,
        'includeDirs': include_dirs,
        'labels': labels,
        'libDir': lib_dir,
        'libName': lib_name,
        'libraries': libraries,
        'licenses': licenses,
        'linkWhole': link_whole,
        'linkWithoutSoname': link_without_soname,
        'platformHeaderDirs': platform_header_dirs,
        'platformSharedLib': platform_shared_lib,
        'platformStaticLib': platform_static_lib,
        'platformStaticPicLib': platform_static_pic_lib,
        'preferredLinkage': preferred_linkage,
        'provided': provided,
        'sharedLib': shared_lib,
        'soname': soname,
        'staticLib': static_lib,
        'staticPicLib': static_pic_lib,
        'supportedPlatformsRegex': supported_platforms_regex,
        'supportsMergedLinking': supports_merged_linking,
        'supportsSharedLibraryInterface': supports_shared_library_interface,
        'versionedHeaderDirs': versioned_header_dirs,
        'versionedSharedLib': versioned_shared_lib,
        'versionedStaticLib': versioned_static_lib,
        'versionedStaticPicLib': versioned_static_pic_lib,
        'versionedSubDir': versioned_sub_dir,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_cxx_library_group(name, deps=None, exported_deps=None, exported_preprocessor_flags=None, include_dirs=None, labels=None, licenses=None, provided_shared_libs=None, shared_libs=None, shared_link=None, static_libs=None, static_link=None, static_pic_libs=None, static_pic_link=None, supported_platforms_regex=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_cxx_library_group',
        'name': name,
        'deps': deps,
        'exportedDeps': exported_deps,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'includeDirs': include_dirs,
        'labels': labels,
        'licenses': licenses,
        'providedSharedLibs': provided_shared_libs,
        'sharedLibs': shared_libs,
        'sharedLink': shared_link,
        'staticLibs': static_libs,
        'staticLink': static_link,
        'staticPicLibs': static_pic_libs,
        'staticPicLink': static_pic_link,
        'supportedPlatformsRegex': supported_platforms_regex,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_precompiled_header(name, src, deps=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_precompiled_header',
        'name': name,
        'src': src,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def js_library(name, worker, base_path=None, deps=None, deps_query=None, extra_args=None, extra_json=None, labels=None, licenses=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'js_library',
        'name': name,
        'worker': worker,
        'basePath': base_path,
        'deps': deps,
        'depsQuery': deps_query,
        'extraArgs': extra_args,
        'extraJson': extra_json,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def js_bundle_genrule(name, js_bundle, bash=None, cmd=None, cmd_exe=None, enable_sandbox=None, environment_expansion_separator=None, labels=None, licenses=None, rewrite_misc=None, rewrite_sourcemap=None, skip_resources=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'js_bundle_genrule',
        'name': name,
        'jsBundle': js_bundle,
        'bash': bash,
        'cmd': cmd,
        'cmdExe': cmd_exe,
        'enableSandbox': enable_sandbox,
        'environmentExpansionSeparator': environment_expansion_separator,
        'labels': labels,
        'licenses': licenses,
        'rewriteMisc': rewrite_misc,
        'rewriteSourcemap': rewrite_sourcemap,
        'skipResources': skip_resources,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def js_bundle(name, entry, worker, android_package=None, bundle_name=None, bundle_name_for_flavor=None, deps=None, extra_json=None, labels=None, library_groups=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'js_bundle',
        'name': name,
        'entry': entry,
        'worker': worker,
        'androidPackage': android_package,
        'bundleName': bundle_name,
        'bundleNameForFlavor': bundle_name_for_flavor,
        'deps': deps,
        'extraJson': extra_json,
        'labels': labels,
        'libraryGroups': library_groups,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def d_binary(name, srcs, deps=None, labels=None, licenses=None, linker_flags=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'd_binary',
        'name': name,
        'srcs': srcs,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def d_library(name, srcs, deps=None, labels=None, licenses=None, linker_flags=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'd_library',
        'name': name,
        'srcs': srcs,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def d_test(name, srcs, contacts=None, deps=None, labels=None, licenses=None, linker_flags=None, test_rule_timeout_ms=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'd_test',
        'name': name,
        'srcs': srcs,
        'contacts': contacts,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def csharp_library(name, framework_ver, deps=None, dll_name=None, labels=None, licenses=None, resources=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'csharp_library',
        'name': name,
        'frameworkVer': framework_ver,
        'deps': deps,
        'dllName': dll_name,
        'labels': labels,
        'licenses': licenses,
        'resources': resources,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_dotnet_library(name, assembly, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_dotnet_library',
        'name': name,
        'assembly': assembly,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def http_archive(name, sha256, labels=None, licenses=None, out=None, strip_prefix=None, type=None, urls=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'http_archive',
        'name': name,
        'sha256': sha256,
        'labels': labels,
        'licenses': licenses,
        'out': out,
        'stripPrefix': strip_prefix,
        'type': type,
        'urls': urls,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def http_file(name, sha256, executable=None, labels=None, licenses=None, out=None, urls=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'http_file',
        'name': name,
        'sha256': sha256,
        'executable': executable,
        'labels': labels,
        'licenses': licenses,
        'out': out,
        'urls': urls,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def remote_file(name, sha1, url, labels=None, licenses=None, out=None, type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'remote_file',
        'name': name,
        'sha1': sha1,
        'url': url,
        'labels': labels,
        'licenses': licenses,
        'out': out,
        'type': type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def haskell_haddock(name, deps=None, deps_query=None, haddock_flags=None, labels=None, licenses=None, platform=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'haskell_haddock',
        'name': name,
        'deps': deps,
        'depsQuery': deps_query,
        'haddockFlags': haddock_flags,
        'labels': labels,
        'licenses': licenses,
        'platform': platform,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def haskell_library(name, compiler_flags=None, deps=None, enable_profiling=None, ghci_platform_preload_deps=None, ghci_preload_deps=None, haddock_flags=None, labels=None, licenses=None, link_whole=None, linker_flags=None, platform_deps=None, preferred_linkage=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'haskell_library',
        'name': name,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'enableProfiling': enable_profiling,
        'ghciPlatformPreloadDeps': ghci_platform_preload_deps,
        'ghciPreloadDeps': ghci_preload_deps,
        'haddockFlags': haddock_flags,
        'labels': labels,
        'licenses': licenses,
        'linkWhole': link_whole,
        'linkerFlags': linker_flags,
        'platformDeps': platform_deps,
        'preferredLinkage': preferred_linkage,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def haskell_binary(name, compiler_flags=None, deps=None, deps_query=None, enable_profiling=None, ghci_platform_preload_deps=None, ghci_preload_deps=None, labels=None, licenses=None, link_deps_query_whole=None, link_style=None, linker_flags=None, main=None, platform=None, platform_deps=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'haskell_binary',
        'name': name,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'depsQuery': deps_query,
        'enableProfiling': enable_profiling,
        'ghciPlatformPreloadDeps': ghci_platform_preload_deps,
        'ghciPreloadDeps': ghci_preload_deps,
        'labels': labels,
        'licenses': licenses,
        'linkDepsQueryWhole': link_deps_query_whole,
        'linkStyle': link_style,
        'linkerFlags': linker_flags,
        'main': main,
        'platform': platform,
        'platformDeps': platform_deps,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def haskell_prebuilt_library(name, db, version, cxx_header_dirs=None, deps=None, enable_profiling=None, exported_compiler_flags=None, exported_linker_flags=None, id=None, import_dirs=None, labels=None, licenses=None, profiled_static_libs=None, shared_libs=None, static_libs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'haskell_prebuilt_library',
        'name': name,
        'db': db,
        'version': version,
        'cxxHeaderDirs': cxx_header_dirs,
        'deps': deps,
        'enableProfiling': enable_profiling,
        'exportedCompilerFlags': exported_compiler_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'id': id,
        'importDirs': import_dirs,
        'labels': labels,
        'licenses': licenses,
        'profiledStaticLibs': profiled_static_libs,
        'sharedLibs': shared_libs,
        'staticLibs': static_libs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def haskell_ghci(name, compiler_flags=None, deps=None, deps_query=None, enable_profiling=None, ghci_bin_dep=None, ghci_init=None, labels=None, licenses=None, linker_flags=None, platform=None, platform_deps=None, platform_preload_deps=None, preload_deps=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'haskell_ghci',
        'name': name,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'depsQuery': deps_query,
        'enableProfiling': enable_profiling,
        'ghciBinDep': ghci_bin_dep,
        'ghciInit': ghci_init,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'platform': platform,
        'platformDeps': platform_deps,
        'platformPreloadDeps': platform_preload_deps,
        'preloadDeps': preload_deps,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cxx_lua_extension(name, base_module=None, compiler_flags=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, linker_extra_outputs=None, linker_flags=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cxx_lua_extension',
        'name': name,
        'baseModule': base_module,
        'compilerFlags': compiler_flags,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def lua_binary(name, main_module, deps=None, labels=None, licenses=None, native_starter_library=None, package_style=None, platform=None, platform_deps=None, python_platform=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'lua_binary',
        'name': name,
        'mainModule': main_module,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'nativeStarterLibrary': native_starter_library,
        'packageStyle': package_style,
        'platform': platform,
        'platformDeps': platform_deps,
        'pythonPlatform': python_platform,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def lua_library(name, base_module=None, deps=None, labels=None, licenses=None, platform_deps=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'lua_library',
        'name': name,
        'baseModule': base_module,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'platformDeps': platform_deps,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def groovy_library(name, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, exported_deps=None, extra_arguments=None, extra_groovyc_arguments=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'groovy_library',
        'name': name,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraGroovycArguments': extra_groovyc_arguments,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def groovy_test(name, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, contacts=None, cxx_library_whitelist=None, default_cxx_platform=None, deps=None, env=None, exported_deps=None, extra_arguments=None, extra_groovyc_arguments=None, fork_mode=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, run_test_separately=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, std_err_log_level=None, std_out_log_level=None, target=None, test_case_timeout_ms=None, test_rule_timeout_ms=None, test_type=None, tests=None, unbundled_resources_root=None, use_cxx_libraries=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'groovy_test',
        'name': name,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'contacts': contacts,
        'cxxLibraryWhitelist': cxx_library_whitelist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'env': env,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'extraGroovycArguments': extra_groovyc_arguments,
        'forkMode': fork_mode,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'runTestSeparately': run_test_separately,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'stdErrLogLevel': std_err_log_level,
        'stdOutLogLevel': std_out_log_level,
        'target': target,
        'testCaseTimeoutMs': test_case_timeout_ms,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'testType': test_type,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'useCxxLibraries': use_cxx_libraries,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_asset_catalog(name, app_icon=None, dirs=None, labels=None, launch_image=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_asset_catalog',
        'name': name,
        'appIcon': app_icon,
        'dirs': dirs,
        'labels': labels,
        'launchImage': launch_image,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_resource(name, dirs=None, files=None, labels=None, licenses=None, resources_from_deps=None, variants=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_resource',
        'name': name,
        'dirs': dirs,
        'files': files,
        'labels': labels,
        'licenses': licenses,
        'resourcesFromDeps': resources_from_deps,
        'variants': variants,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def core_data_model(name, path, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'core_data_model',
        'name': name,
        'path': path,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def xcode_workspace_config(name, action_config_names=None, additional_scheme_actions=None, environment_variables=None, explicit_runnable_path=None, extra_schemes=None, extra_targets=None, extra_tests=None, is_remote_runnable=None, labels=None, launch_style=None, licenses=None, src_target=None, workspace_name=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'xcode_workspace_config',
        'name': name,
        'actionConfigNames': action_config_names,
        'additionalSchemeActions': additional_scheme_actions,
        'environmentVariables': environment_variables,
        'explicitRunnablePath': explicit_runnable_path,
        'extraSchemes': extra_schemes,
        'extraTargets': extra_targets,
        'extraTests': extra_tests,
        'isRemoteRunnable': is_remote_runnable,
        'labels': labels,
        'launchStyle': launch_style,
        'licenses': licenses,
        'srcTarget': src_target,
        'workspaceName': workspace_name,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def xcode_prebuild_script(name, cmd, labels=None, licenses=None, outputs=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'xcode_prebuild_script',
        'name': name,
        'cmd': cmd,
        'labels': labels,
        'licenses': licenses,
        'outputs': outputs,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def xcode_postbuild_script(name, cmd, labels=None, licenses=None, outputs=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'xcode_postbuild_script',
        'name': name,
        'cmd': cmd,
        'labels': labels,
        'licenses': licenses,
        'outputs': outputs,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_library(name, bridging_header=None, can_be_asset=None, compiler_flags=None, configs=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, exported_deps=None, exported_headers=None, exported_lang_preprocessor_flags=None, exported_linker_flags=None, exported_platform_deps=None, exported_platform_headers=None, exported_platform_linker_flags=None, exported_platform_preprocessor_flags=None, exported_preprocessor_flags=None, extra_xcode_files=None, extra_xcode_sources=None, force_static=None, frameworks=None, header_namespace=None, header_path_prefix=None, headers=None, include_dirs=None, info_plist=None, info_plist_substitutions=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_style=None, link_whole=None, linker_extra_outputs=None, linker_flags=None, min_deployment_version=None, modular=None, module_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, preferred_linkage=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, reexport_all_header_dependencies=None, soname=None, srcs=None, static_library_basename=None, supported_platforms_regex=None, swift_compiler_flags=None, swift_version=None, tests=None, thin_lto=None, xcode_private_headers_symlinks=None, xcode_public_headers_symlinks=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_library',
        'name': name,
        'bridgingHeader': bridging_header,
        'canBeAsset': can_be_asset,
        'compilerFlags': compiler_flags,
        'configs': configs,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'exportedDeps': exported_deps,
        'exportedHeaders': exported_headers,
        'exportedLangPreprocessorFlags': exported_lang_preprocessor_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformDeps': exported_platform_deps,
        'exportedPlatformHeaders': exported_platform_headers,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'exportedPlatformPreprocessorFlags': exported_platform_preprocessor_flags,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'extraXcodeFiles': extra_xcode_files,
        'extraXcodeSources': extra_xcode_sources,
        'forceStatic': force_static,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headerPathPrefix': header_path_prefix,
        'headers': headers,
        'includeDirs': include_dirs,
        'infoPlist': info_plist,
        'infoPlistSubstitutions': info_plist_substitutions,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkWhole': link_whole,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'minDeploymentVersion': min_deployment_version,
        'modular': modular,
        'moduleName': module_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'preferredLinkage': preferred_linkage,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'reexportAllHeaderDependencies': reexport_all_header_dependencies,
        'soname': soname,
        'srcs': srcs,
        'staticLibraryBasename': static_library_basename,
        'supportedPlatformsRegex': supported_platforms_regex,
        'swiftCompilerFlags': swift_compiler_flags,
        'swiftVersion': swift_version,
        'tests': tests,
        'thinLto': thin_lto,
        'xcodePrivateHeadersSymlinks': xcode_private_headers_symlinks,
        'xcodePublicHeadersSymlinks': xcode_public_headers_symlinks,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_apple_framework(name, framework, preferred_linkage, deps=None, exported_linker_flags=None, exported_platform_linker_flags=None, frameworks=None, labels=None, libraries=None, licenses=None, supported_platforms_regex=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_apple_framework',
        'name': name,
        'framework': framework,
        'preferredLinkage': preferred_linkage,
        'deps': deps,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'frameworks': frameworks,
        'labels': labels,
        'libraries': libraries,
        'licenses': licenses,
        'supportedPlatformsRegex': supported_platforms_regex,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_binary(name, bridging_header=None, can_be_asset=None, compiler_flags=None, configs=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, entitlements_file=None, exported_deps=None, exported_headers=None, exported_lang_preprocessor_flags=None, exported_linker_flags=None, exported_platform_deps=None, exported_platform_headers=None, exported_platform_linker_flags=None, exported_platform_preprocessor_flags=None, exported_preprocessor_flags=None, extra_xcode_files=None, extra_xcode_sources=None, force_static=None, frameworks=None, header_namespace=None, header_path_prefix=None, headers=None, include_dirs=None, info_plist=None, info_plist_substitutions=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_style=None, link_whole=None, linker_extra_outputs=None, linker_flags=None, min_deployment_version=None, modular=None, module_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, preferred_linkage=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, reexport_all_header_dependencies=None, soname=None, srcs=None, static_library_basename=None, supported_platforms_regex=None, swift_compiler_flags=None, swift_version=None, tests=None, thin_lto=None, xcode_private_headers_symlinks=None, xcode_public_headers_symlinks=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_binary',
        'name': name,
        'bridgingHeader': bridging_header,
        'canBeAsset': can_be_asset,
        'compilerFlags': compiler_flags,
        'configs': configs,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'entitlementsFile': entitlements_file,
        'exportedDeps': exported_deps,
        'exportedHeaders': exported_headers,
        'exportedLangPreprocessorFlags': exported_lang_preprocessor_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformDeps': exported_platform_deps,
        'exportedPlatformHeaders': exported_platform_headers,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'exportedPlatformPreprocessorFlags': exported_platform_preprocessor_flags,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'extraXcodeFiles': extra_xcode_files,
        'extraXcodeSources': extra_xcode_sources,
        'forceStatic': force_static,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headerPathPrefix': header_path_prefix,
        'headers': headers,
        'includeDirs': include_dirs,
        'infoPlist': info_plist,
        'infoPlistSubstitutions': info_plist_substitutions,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkWhole': link_whole,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'minDeploymentVersion': min_deployment_version,
        'modular': modular,
        'moduleName': module_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'preferredLinkage': preferred_linkage,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'reexportAllHeaderDependencies': reexport_all_header_dependencies,
        'soname': soname,
        'srcs': srcs,
        'staticLibraryBasename': static_library_basename,
        'supportedPlatformsRegex': supported_platforms_regex,
        'swiftCompilerFlags': swift_compiler_flags,
        'swiftVersion': swift_version,
        'tests': tests,
        'thinLto': thin_lto,
        'xcodePrivateHeadersSymlinks': xcode_private_headers_symlinks,
        'xcodePublicHeadersSymlinks': xcode_public_headers_symlinks,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_package(name, bundle, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_package',
        'name': name,
        'bundle': bundle,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_bundle(name, binary, extension, info_plist, asset_catalogs_compilation_options=None, codesign_flags=None, codesign_identity=None, default_platform=None, deps=None, ibtool_module_flag=None, info_plist_substitutions=None, labels=None, licenses=None, min_deployment_version=None, product_name=None, tests=None, xcode_product_type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_bundle',
        'name': name,
        'binary': binary,
        'extension': extension,
        'infoPlist': info_plist,
        'assetCatalogsCompilationOptions': asset_catalogs_compilation_options,
        'codesignFlags': codesign_flags,
        'codesignIdentity': codesign_identity,
        'defaultPlatform': default_platform,
        'deps': deps,
        'ibtoolModuleFlag': ibtool_module_flag,
        'infoPlistSubstitutions': info_plist_substitutions,
        'labels': labels,
        'licenses': licenses,
        'minDeploymentVersion': min_deployment_version,
        'productName': product_name,
        'tests': tests,
        'xcodeProductType': xcode_product_type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def apple_test(name, info_plist, asset_catalogs_compilation_options=None, bridging_header=None, can_be_asset=None, codesign_flags=None, codesign_identity=None, compiler_flags=None, configs=None, contacts=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, destination_specifier=None, entitlements_file=None, environment=None, exported_deps=None, exported_headers=None, exported_lang_preprocessor_flags=None, exported_linker_flags=None, exported_platform_deps=None, exported_platform_headers=None, exported_platform_linker_flags=None, exported_platform_preprocessor_flags=None, exported_preprocessor_flags=None, extra_xcode_files=None, extra_xcode_sources=None, force_static=None, frameworks=None, header_namespace=None, header_path_prefix=None, headers=None, include_dirs=None, info_plist_substitutions=None, is_ui_test=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_style=None, link_whole=None, linker_extra_outputs=None, linker_flags=None, min_deployment_version=None, modular=None, module_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, preferred_linkage=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, reexport_all_header_dependencies=None, run_test_separately=None, snapshot_reference_images_path=None, soname=None, srcs=None, static_library_basename=None, supported_platforms_regex=None, swift_compiler_flags=None, swift_version=None, test_host_app=None, test_rule_timeout_ms=None, tests=None, thin_lto=None, ui_test_target_app=None, xcode_private_headers_symlinks=None, xcode_product_type=None, xcode_public_headers_symlinks=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'apple_test',
        'name': name,
        'infoPlist': info_plist,
        'assetCatalogsCompilationOptions': asset_catalogs_compilation_options,
        'bridgingHeader': bridging_header,
        'canBeAsset': can_be_asset,
        'codesignFlags': codesign_flags,
        'codesignIdentity': codesign_identity,
        'compilerFlags': compiler_flags,
        'configs': configs,
        'contacts': contacts,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'destinationSpecifier': destination_specifier,
        'entitlementsFile': entitlements_file,
        'environment': environment,
        'exportedDeps': exported_deps,
        'exportedHeaders': exported_headers,
        'exportedLangPreprocessorFlags': exported_lang_preprocessor_flags,
        'exportedLinkerFlags': exported_linker_flags,
        'exportedPlatformDeps': exported_platform_deps,
        'exportedPlatformHeaders': exported_platform_headers,
        'exportedPlatformLinkerFlags': exported_platform_linker_flags,
        'exportedPlatformPreprocessorFlags': exported_platform_preprocessor_flags,
        'exportedPreprocessorFlags': exported_preprocessor_flags,
        'extraXcodeFiles': extra_xcode_files,
        'extraXcodeSources': extra_xcode_sources,
        'forceStatic': force_static,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headerPathPrefix': header_path_prefix,
        'headers': headers,
        'includeDirs': include_dirs,
        'infoPlistSubstitutions': info_plist_substitutions,
        'isUiTest': is_ui_test,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkWhole': link_whole,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'minDeploymentVersion': min_deployment_version,
        'modular': modular,
        'moduleName': module_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'preferredLinkage': preferred_linkage,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'reexportAllHeaderDependencies': reexport_all_header_dependencies,
        'runTestSeparately': run_test_separately,
        'snapshotReferenceImagesPath': snapshot_reference_images_path,
        'soname': soname,
        'srcs': srcs,
        'staticLibraryBasename': static_library_basename,
        'supportedPlatformsRegex': supported_platforms_regex,
        'swiftCompilerFlags': swift_compiler_flags,
        'swiftVersion': swift_version,
        'testHostApp': test_host_app,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'tests': tests,
        'thinLto': thin_lto,
        'uiTestTargetApp': ui_test_target_app,
        'xcodePrivateHeadersSymlinks': xcode_private_headers_symlinks,
        'xcodeProductType': xcode_product_type,
        'xcodePublicHeadersSymlinks': xcode_public_headers_symlinks,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def scene_kit_assets(name, path, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'scene_kit_assets',
        'name': name,
        'path': path,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def versioned_alias(name, labels=None, licenses=None, versions=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'versioned_alias',
        'name': name,
        'labels': labels,
        'licenses': licenses,
        'versions': versions,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def command_alias(name, args=None, env=None, exe=None, labels=None, licenses=None, platform_exe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'command_alias',
        'name': name,
        'args': args,
        'env': env,
        'exe': exe,
        'labels': labels,
        'licenses': licenses,
        'platformExe': platform_exe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def export_file(name, labels=None, licenses=None, mode=None, out=None, src=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'export_file',
        'name': name,
        'labels': labels,
        'licenses': licenses,
        'mode': mode,
        'out': out,
        'src': src,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def genrule(name, out, bash=None, cacheable=None, cmd=None, cmd_exe=None, enable_sandbox=None, environment_expansion_separator=None, executable=None, labels=None, licenses=None, srcs=None, tests=None, type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'genrule',
        'name': name,
        'out': out,
        'bash': bash,
        'cacheable': cacheable,
        'cmd': cmd,
        'cmdExe': cmd_exe,
        'enableSandbox': enable_sandbox,
        'environmentExpansionSeparator': environment_expansion_separator,
        'executable': executable,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'tests': tests,
        'type': type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def sh_binary(name, main, deps=None, labels=None, licenses=None, resources=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'sh_binary',
        'name': name,
        'main': main,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'resources': resources,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def sh_test(name, args=None, contacts=None, deps=None, env=None, labels=None, licenses=None, resources=None, run_test_separately=None, test=None, test_rule_timeout_ms=None, type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'sh_test',
        'name': name,
        'args': args,
        'contacts': contacts,
        'deps': deps,
        'env': env,
        'labels': labels,
        'licenses': licenses,
        'resources': resources,
        'runTestSeparately': run_test_separately,
        'test': test,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'type': type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def worker_tool(name, args=None, env=None, exe=None, labels=None, licenses=None, max_workers=None, persistent=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'worker_tool',
        'name': name,
        'args': args,
        'env': env,
        'exe': exe,
        'labels': labels,
        'licenses': licenses,
        'maxWorkers': max_workers,
        'persistent': persistent,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def swift_library(name, bridging_header=None, compiler_flags=None, deps=None, enable_objc_interop=None, frameworks=None, labels=None, libraries=None, licenses=None, min_deployment_version=None, module_name=None, preferred_linkage=None, soname=None, srcs=None, supported_platforms_regex=None, version=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'swift_library',
        'name': name,
        'bridgingHeader': bridging_header,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'enableObjcInterop': enable_objc_interop,
        'frameworks': frameworks,
        'labels': labels,
        'libraries': libraries,
        'licenses': licenses,
        'minDeploymentVersion': min_deployment_version,
        'moduleName': module_name,
        'preferredLinkage': preferred_linkage,
        'soname': soname,
        'srcs': srcs,
        'supportedPlatformsRegex': supported_platforms_regex,
        'version': version,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def go_binary(name, assembler_flags=None, cgo_deps=None, compiler_flags=None, deps=None, labels=None, licenses=None, linker_flags=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'go_binary',
        'name': name,
        'assemblerFlags': assembler_flags,
        'cgoDeps': cgo_deps,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def go_library(name, assembler_flags=None, cgo_deps=None, compiler_flags=None, deps=None, exported_deps=None, labels=None, licenses=None, package_name=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'go_library',
        'name': name,
        'assemblerFlags': assembler_flags,
        'cgoDeps': cgo_deps,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'exportedDeps': exported_deps,
        'labels': labels,
        'licenses': licenses,
        'packageName': package_name,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def cgo_library(name, cgo_compiler_flags=None, compiler_flags=None, cxx_runtime_type=None, default_platform=None, defaults=None, deps=None, deps_query=None, frameworks=None, header_namespace=None, headers=None, include_dirs=None, labels=None, lang_compiler_flags=None, lang_preprocessor_flags=None, libraries=None, licenses=None, link_deps_query_whole=None, link_style=None, linker_extra_outputs=None, linker_flags=None, package_name=None, platform_compiler_flags=None, platform_deps=None, platform_headers=None, platform_linker_flags=None, platform_preprocessor_flags=None, platform_srcs=None, precompiled_header=None, prefix_header=None, preprocessor_flags=None, raw_headers=None, srcs=None, tests=None, thin_lto=None, version_universe=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'cgo_library',
        'name': name,
        'cgoCompilerFlags': cgo_compiler_flags,
        'compilerFlags': compiler_flags,
        'cxxRuntimeType': cxx_runtime_type,
        'defaultPlatform': default_platform,
        'defaults': defaults,
        'deps': deps,
        'depsQuery': deps_query,
        'frameworks': frameworks,
        'headerNamespace': header_namespace,
        'headers': headers,
        'includeDirs': include_dirs,
        'labels': labels,
        'langCompilerFlags': lang_compiler_flags,
        'langPreprocessorFlags': lang_preprocessor_flags,
        'libraries': libraries,
        'licenses': licenses,
        'linkDepsQueryWhole': link_deps_query_whole,
        'linkStyle': link_style,
        'linkerExtraOutputs': linker_extra_outputs,
        'linkerFlags': linker_flags,
        'packageName': package_name,
        'platformCompilerFlags': platform_compiler_flags,
        'platformDeps': platform_deps,
        'platformHeaders': platform_headers,
        'platformLinkerFlags': platform_linker_flags,
        'platformPreprocessorFlags': platform_preprocessor_flags,
        'platformSrcs': platform_srcs,
        'precompiledHeader': precompiled_header,
        'prefixHeader': prefix_header,
        'preprocessorFlags': preprocessor_flags,
        'rawHeaders': raw_headers,
        'srcs': srcs,
        'tests': tests,
        'thinLto': thin_lto,
        'versionUniverse': version_universe,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def go_test(name, assembler_flags=None, cgo_deps=None, compiler_flags=None, contacts=None, coverage_mode=None, deps=None, labels=None, library=None, licenses=None, linker_flags=None, package_name=None, resources=None, run_test_separately=None, srcs=None, test_rule_timeout_ms=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'go_test',
        'name': name,
        'assemblerFlags': assembler_flags,
        'cgoDeps': cgo_deps,
        'compilerFlags': compiler_flags,
        'contacts': contacts,
        'coverageMode': coverage_mode,
        'deps': deps,
        'labels': labels,
        'library': library,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'packageName': package_name,
        'resources': resources,
        'runTestSeparately': run_test_separately,
        'srcs': srcs,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def jar_genrule(name, bash=None, cacheable=None, cmd=None, cmd_exe=None, enable_sandbox=None, environment_expansion_separator=None, labels=None, licenses=None, srcs=None, tests=None, type=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'jar_genrule',
        'name': name,
        'bash': bash,
        'cacheable': cacheable,
        'cmd': cmd,
        'cmdExe': cmd_exe,
        'enableSandbox': enable_sandbox,
        'environmentExpansionSeparator': environment_expansion_separator,
        'labels': labels,
        'licenses': licenses,
        'srcs': srcs,
        'tests': tests,
        'type': type,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def java_binary(name, blacklist=None, default_cxx_platform=None, deps=None, disallow_all_duplicates=None, labels=None, licenses=None, main_class=None, manifest_file=None, merge_manifests=None, meta_inf_directory=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'java_binary',
        'name': name,
        'blacklist': blacklist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'disallowAllDuplicates': disallow_all_duplicates,
        'labels': labels,
        'licenses': licenses,
        'mainClass': main_class,
        'manifestFile': manifest_file,
        'mergeManifests': merge_manifests,
        'metaInfDirectory': meta_inf_directory,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def java_annotation_processor(name, processor_class, deps=None, does_not_affect_abi=None, isolate_class_loader=None, labels=None, licenses=None, supports_abi_generation_from_source=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'java_annotation_processor',
        'name': name,
        'processorClass': processor_class,
        'deps': deps,
        'doesNotAffectAbi': does_not_affect_abi,
        'isolateClassLoader': isolate_class_loader,
        'labels': labels,
        'licenses': licenses,
        'supportsAbiGenerationFromSource': supports_abi_generation_from_source,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def java_library(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, exported_deps=None, extra_arguments=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'java_library',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def java_test(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, contacts=None, cxx_library_whitelist=None, default_cxx_platform=None, deps=None, env=None, exported_deps=None, extra_arguments=None, fork_mode=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, run_test_separately=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, std_err_log_level=None, std_out_log_level=None, target=None, test_case_timeout_ms=None, test_rule_timeout_ms=None, test_type=None, tests=None, unbundled_resources_root=None, use_cxx_libraries=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'java_test',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'contacts': contacts,
        'cxxLibraryWhitelist': cxx_library_whitelist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'env': env,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'forkMode': fork_mode,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'runTestSeparately': run_test_separately,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'stdErrLogLevel': std_err_log_level,
        'stdOutLogLevel': std_out_log_level,
        'target': target,
        'testCaseTimeoutMs': test_case_timeout_ms,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'testType': test_type,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'useCxxLibraries': use_cxx_libraries,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def keystore(name, properties, store, deps=None, labels=None, licenses=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'keystore',
        'name': name,
        'properties': properties,
        'store': store,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def scala_library(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, deps=None, exported_deps=None, extra_arguments=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, target=None, tests=None, unbundled_resources_root=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'scala_library',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'deps': deps,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'target': target,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def scala_test(name, abi_generation_mode=None, annotation_processor_deps=None, annotation_processor_only=None, annotation_processor_params=None, annotation_processors=None, compile_against=None, compiler=None, compiler_class_name=None, contacts=None, cxx_library_whitelist=None, default_cxx_platform=None, deps=None, env=None, exported_deps=None, extra_arguments=None, fork_mode=None, java_version=None, javac=None, javac_jar=None, labels=None, licenses=None, manifest_file=None, maven_coords=None, maven_pom_template=None, plugins=None, postprocess_classes_commands=None, proguard_config=None, provided_deps=None, remove_classes=None, required_for_source_only_abi=None, resources=None, resources_root=None, run_test_separately=None, source=None, source_abi_verification_mode=None, source_only_abi_deps=None, srcs=None, std_err_log_level=None, std_out_log_level=None, target=None, test_case_timeout_ms=None, test_rule_timeout_ms=None, test_type=None, tests=None, unbundled_resources_root=None, use_cxx_libraries=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'scala_test',
        'name': name,
        'abiGenerationMode': abi_generation_mode,
        'annotationProcessorDeps': annotation_processor_deps,
        'annotationProcessorOnly': annotation_processor_only,
        'annotationProcessorParams': annotation_processor_params,
        'annotationProcessors': annotation_processors,
        'compileAgainst': compile_against,
        'compiler': compiler,
        'compilerClassName': compiler_class_name,
        'contacts': contacts,
        'cxxLibraryWhitelist': cxx_library_whitelist,
        'defaultCxxPlatform': default_cxx_platform,
        'deps': deps,
        'env': env,
        'exportedDeps': exported_deps,
        'extraArguments': extra_arguments,
        'forkMode': fork_mode,
        'javaVersion': java_version,
        'javac': javac,
        'javacJar': javac_jar,
        'labels': labels,
        'licenses': licenses,
        'manifestFile': manifest_file,
        'mavenCoords': maven_coords,
        'mavenPomTemplate': maven_pom_template,
        'plugins': plugins,
        'postprocessClassesCommands': postprocess_classes_commands,
        'proguardConfig': proguard_config,
        'providedDeps': provided_deps,
        'removeClasses': remove_classes,
        'requiredForSourceOnlyAbi': required_for_source_only_abi,
        'resources': resources,
        'resourcesRoot': resources_root,
        'runTestSeparately': run_test_separately,
        'source': source,
        'sourceAbiVerificationMode': source_abi_verification_mode,
        'sourceOnlyAbiDeps': source_only_abi_deps,
        'srcs': srcs,
        'stdErrLogLevel': std_err_log_level,
        'stdOutLogLevel': std_out_log_level,
        'target': target,
        'testCaseTimeoutMs': test_case_timeout_ms,
        'testRuleTimeoutMs': test_rule_timeout_ms,
        'testType': test_type,
        'tests': tests,
        'unbundledResourcesRoot': unbundled_resources_root,
        'useCxxLibraries': use_cxx_libraries,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def gwt_binary(name, deps=None, draft_compile=None, experimental_args=None, labels=None, licenses=None, local_workers=None, module_deps=None, modules=None, optimize=None, strict=None, style=None, vm_args=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'gwt_binary',
        'name': name,
        'deps': deps,
        'draftCompile': draft_compile,
        'experimentalArgs': experimental_args,
        'labels': labels,
        'licenses': licenses,
        'localWorkers': local_workers,
        'moduleDeps': module_deps,
        'modules': modules,
        'optimize': optimize,
        'strict': strict,
        'style': style,
        'vmArgs': vm_args,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def ocaml_binary(name, bytecode_only=None, compiler_flags=None, deps=None, labels=None, licenses=None, linker_flags=None, srcs=None, warnings_flags=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'ocaml_binary',
        'name': name,
        'bytecodeOnly': bytecode_only,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'srcs': srcs,
        'warningsFlags': warnings_flags,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def ocaml_library(name, bytecode_only=None, compiler_flags=None, deps=None, labels=None, licenses=None, linker_flags=None, native_plugin=None, srcs=None, warnings_flags=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'ocaml_library',
        'name': name,
        'bytecodeOnly': bytecode_only,
        'compilerFlags': compiler_flags,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkerFlags': linker_flags,
        'nativePlugin': native_plugin,
        'srcs': srcs,
        'warningsFlags': warnings_flags,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_ocaml_library(name, bytecode_lib=None, bytecode_only=None, c_libs=None, deps=None, include_dir=None, labels=None, lib_dir=None, lib_name=None, licenses=None, native_lib=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_ocaml_library',
        'name': name,
        'bytecodeLib': bytecode_lib,
        'bytecodeOnly': bytecode_only,
        'cLibs': c_libs,
        'deps': deps,
        'includeDir': include_dir,
        'labels': labels,
        'libDir': lib_dir,
        'libName': lib_name,
        'licenses': licenses,
        'nativeLib': native_lib,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def rust_binary(name, crate=None, crate_root=None, deps=None, features=None, labels=None, licenses=None, link_style=None, linker_flags=None, rpath=None, rustc_flags=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'rust_binary',
        'name': name,
        'crate': crate,
        'crateRoot': crate_root,
        'deps': deps,
        'features': features,
        'labels': labels,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkerFlags': linker_flags,
        'rpath': rpath,
        'rustcFlags': rustc_flags,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def rust_library(name, crate=None, crate_root=None, deps=None, features=None, labels=None, licenses=None, preferred_linkage=None, proc_macro=None, rustc_flags=None, srcs=None, tests=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'rust_library',
        'name': name,
        'crate': crate,
        'crateRoot': crate_root,
        'deps': deps,
        'features': features,
        'labels': labels,
        'licenses': licenses,
        'preferredLinkage': preferred_linkage,
        'procMacro': proc_macro,
        'rustcFlags': rustc_flags,
        'srcs': srcs,
        'tests': tests,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def rust_test(name, contacts=None, crate=None, crate_root=None, deps=None, features=None, framework=None, labels=None, licenses=None, link_style=None, linker_flags=None, rpath=None, rustc_flags=None, srcs=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'rust_test',
        'name': name,
        'contacts': contacts,
        'crate': crate,
        'crateRoot': crate_root,
        'deps': deps,
        'features': features,
        'framework': framework,
        'labels': labels,
        'licenses': licenses,
        'linkStyle': link_style,
        'linkerFlags': linker_flags,
        'rpath': rpath,
        'rustcFlags': rustc_flags,
        'srcs': srcs,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


@provide_as_native_rule
def prebuilt_rust_library(name, rlib, crate=None, deps=None, labels=None, licenses=None, link_style=None, proc_macro=None, visibility=None, within_view=None, build_env=None):
    add_rule({
        'buck.type': 'prebuilt_rust_library',
        'name': name,
        'rlib': rlib,
        'crate': crate,
        'deps': deps,
        'labels': labels,
        'licenses': licenses,
        'linkStyle': link_style,
        'procMacro': proc_macro,
        'visibility': visibility,
        'within_view': within_view,
    }, build_env)


