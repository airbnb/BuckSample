


# shared configuration settings for app targets
config = {
    "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "YES",
    "DEVELOPMENT_LANGUAGE": "Swift",
    # "EXECUTABLE_NAME": "AirbnbItineraryApp",
    # "PRODUCT_BUNDLE_IDENTIFIER": "com.airbnb.AirbnbItineraryApp",
    "ONLY_ACTIVE_ARCH": "YES",
    "TARGETED_DEVICE_FAMILY": "1,2",
    "SDKROOT": "iphoneos"
}

DEFAULT_CONFIGS = {
    "Debug": config,
    "Profile": config,
    "Release": config,
}
