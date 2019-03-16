OTHER_LINKER_FLAGS_KEY = 'OTHER_LDFLAGS'

# ## Clarification
#
# `config` and `configs` dictionaries can be easily confused.
#
# A `config` (singular) dictionary is a bag of settings that pertains to a particular build
# configuration (e.g. Debug, Release).
#
# {
#   "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
#   "DEVELOPMENT_LANGUAGE": "Swift",
#   /* ... */
# }
#
# A `configs` (plural) dictionary is a union of `config` dictionaries, keyed by the build
# configuration.
#
# {
#   "Debug": {
#     "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
#     "DEVELOPMENT_LANGUAGE": "Swift",
#     /* ... */
#   },
#   "Release": {
#     "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
#     "DEVELOPMENT_LANGUAGE": "Swift",
#     /* ... */
#   }
# }

# Creates a dictionary where the top level keys are the supported build configurations and the value of each key is `config`.
def configs_with_config(config):
    return {
        "Debug": config,
        "Profile": config,
        "Release": config,
    }

def configs_without_key(configs, key):
    modified_configs = configs.copy()
    for configs_key in configs:
        if configs[configs_key].has_key(key):
            modified_configs[configs_key].pop(key)
    return modified_configs

# Creates a new dictionary of `configs` that includes `other_linker_flags`.
# Params:
# - configs: A dictionary where every key is a build config and the value is another dict of configs for that build
# - additional_linker_flags: A string-representable value of additional linker flags
def configs_with_updated_linker_flags(configs, other_linker_flags):
    if other_linker_flags is None:
        return configs
    else:
        updated_configs = { }
        for build_configuration in configs:
            updated_configs[build_configuration] = config_with_updated_linker_flags(
                configs[build_configuration],
                other_linker_flags)
        return updated_configs

# Either appends or assigns `other_linker_flags` to `config` under `config_key`.
# Params:
# - config: A dictionary of config names and their values
# - additional_linker_flags: A string-representable value of additional linker flags
# - config_key: The key to which to append or assign the additional linker flags
def config_with_updated_linker_flags(config, other_linker_flags, config_key=OTHER_LINKER_FLAGS_KEY):
    config_copy = config.copy()
    if config_key in config_copy:
        config_copy[config_key] += ' ' + other_linker_flags
    else:
        config_copy[config_key] = '$(inherited) ' + other_linker_flags
    return config_copy
