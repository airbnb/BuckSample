def pretty(dict, current=""):
    current = "\n"
    indent = 0
    for key, value in dict.items():
        current = current + str(key) + ':\n'
        if type(value) == type({}):
            indent = 1
            for key2, value2 in value.items():
                current = current + '\t' * indent + str(key2)
                current = current + ": " + str(value2) + '\n'
        else:
            current = current + '\t' * (indent+1) + str(value)
            
    return current

   
def library_configs():
    LIBRARY_CONFIGS = {
    'SWIFT_OPTIMIZATION_LEVEL' : 'none',
    'SWIFT_WHOLE_MODULE_OPTIMIZATION': 'YES',
    'ONLY_ACTIVE_ARCH': 'YES',
    'SDKROOT': 'iphoneos',
    'GCC_OPTIMIZATION_LEVEL': '0',
    # 'SWIFT_OPTIMIZATION_LEVEL': 'none',
    }
    configs = {
        "Debug": LIBRARY_CONFIGS,
        "Profile": LIBRARY_CONFIGS,
        "Release": LIBRARY_CONFIGS,
    }
    return configs


BINARY_CONFIGS =  {
  'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' : 'YES',
  'DEVELOPMENT_LANGUAGE': 'Swift',
  'SDKROOT': 'iphoneos',
  'GCC_OPTIMIZATION_LEVEL': '0',
  'SWIFT_OPTIMIZATION_LEVEL': 'none',
}

def binary_configs(name, bundle_identifier):
  config = {key: BINARY_CONFIGS[key] for key in BINARY_CONFIGS.keys()}
  # config['EXECUTABLE_NAME'] = name
  config['PRODUCT_BUNDLE_IDENTIFIER'] = bundle_identifier
  binary_configs = {
    "Debug": config,
    "Profile": config,
    "Release": config,
  }
  return binary_configs


def pod_library_configs():
    pod_configs = LIBRARY_CONFIGS
    pod_configs['GCC_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
    pod_library_configs = {
        "Debug": pod_configs,
        "Profile": pod_configs,
        "Release": pod_configs,
    }
    return pod_library_configs
