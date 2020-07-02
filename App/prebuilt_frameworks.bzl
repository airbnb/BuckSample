prebuilt_frameworks = [
    "//Carthage:AFNetworking",

    # Hack to enable project generation to work for the Carthage BUCK file which otherwise only has `prebuilt_apple_framework`s.
    "//Carthage:CarthageProjectGeneratorHack",
]
