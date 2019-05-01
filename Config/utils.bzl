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
#   "DEVELOPMENT_LANGUAGE": "en",
#   /* ... */
# }
#
# A `configs` (plural) dictionary is a union of `config` dictionaries, keyed by the build
# configuration.
#
# {
#   "Debug": {
#     "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
#     "DEVELOPMENT_LANGUAGE": "en",
#     /* ... */
#   },
#   "Release": {
#     "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
#     "DEVELOPMENT_LANGUAGE": "en",
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

# Creates a new dictionary of `configs` that includes `other_linker_flags`.
# Params:
# - configs: A dictionary where every key is a build config and the value is another dict of configs for that build
# - additional_linker_flags: A string-representable value of additional linker flags
def configs_with_updated_linker_flags(configs, other_linker_flags):
    if other_linker_flags == None:
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
    new_config = { }
    config_key_found = False
    for key in config:
        if key == config_key:
            new_config[key] = config[key] + (" %s" % other_linker_flags)
            config_key_found = True
        else:
            new_config[key] = config[key]

    if config_key_found == False:
        # If `config` does not currently contain `config_key`, add it. Inherit for good measure.
        new_config[config_key] = '$(inherited) ' + other_linker_flags

    return new_config
