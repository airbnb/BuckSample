import CoreLocation.CLGeocoder
#if !PMKCocoaPods
import PromiseKit
#endif

/**
 To import the `CLGeocoder` category:

    use_frameworks!
    pod "PromiseKit/CoreLocation"

 And then in your sources:

    import PromiseKit
*/
extension CLGeocoder {
    /// Submits a reverse-geocoding request for the specified location.
    public func reverseGeocode(location: CLLocation) -> Promise<[CLPlacemark]> {
        return Promise { seal in
            reverseGeocodeLocation(location, completionHandler: seal.resolve)
        }
    }

    /// Submits a forward-geocoding request using the specified address dictionary.
    public func geocode(_ addressDictionary: [String: String]) -> Promise<[CLPlacemark]> {
        return Promise { seal in
            geocodeAddressDictionary(addressDictionary, completionHandler: seal.resolve)
        }
    }

    /// Submits a forward-geocoding request using the specified address string.
    public func geocode(_ addressString: String) -> Promise<[CLPlacemark]> {
        return Promise { seal in
            geocodeAddressString(addressString, completionHandler: seal.resolve)
        }
    }

    /// Submits a forward-geocoding request using the specified address string within the specified region.
    public func geocode(_ addressString: String, region: CLRegion?) -> Promise<[CLPlacemark]> {
        return Promise { seal in
            geocodeAddressString(addressString, in: region, completionHandler: seal.resolve)
        }
    }
}

// TODO still not possible in Swift 3.2
//extension CLError: CancellableError {
//    public var isCancelled: Bool {
//        return self == .geocodeCanceled
//    }
//}
