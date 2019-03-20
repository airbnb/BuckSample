import CoreLocation.CLLocationManager
#if !PMKCocoaPods
import PromiseKit
#endif

#if !os(tvOS)

/**
 To import the `CLLocationManager` category:

    use_frameworks!
    pod "PromiseKit/CoreLocation"

 And then in your sources:

    import PromiseKit
*/
extension CLLocationManager {

    /// The location authorization type
    public enum RequestAuthorizationType {
        /// Determine the authorization from the application’s plist
        case automatic
        /// Request always-authorization
        case always
        /// Request when-in-use-authorization
        case whenInUse
    }

    /// Request a single location using promises
    /// - Note: To return all locations call `allResults()`.
    ///
    /// - Parameters:
    ///   - authorizationType: requestAuthorizationType: We read your Info plist and try to
    ///     determine the authorization type we should request automatically. If you
    ///     want to force one or the other, change this parameter from its default
    ///     value.
    ///   - block: A block by which to perform any filtering of the locations
    ///            that are returned. For example:
    ///                 - In order to only retrieve accurate locations, only
    ///                   return true if the locations horizontal accuracy < 50
    ///
    /// - Returns: A new promise that fulfills with the most recent CLLocation
    ///            that satisfies the provided block if it exists. If the block
    ///            does not exist, simply return the last location.
    public class func requestLocation(authorizationType: RequestAuthorizationType = .automatic, satisfying block: ((CLLocation) -> Bool)? = nil) -> Promise<[CLLocation]> {
        return promise(yielding: auther(authorizationType), satisfying: block)
    }

    @available(*, deprecated: 5.0, renamed: "requestLocation")
    public class func promise(_ requestAuthorizationType: RequestAuthorizationType = .automatic, satisfying block: ((CLLocation) -> Bool)? = nil) -> Promise<[CLLocation]> {
        return requestLocation(authorizationType: requestAuthorizationType, satisfying: block)
    }

    private class func promise(yielding yield: (CLLocationManager) -> Void = { _ in }, satisfying block: ((CLLocation) -> Bool)? = nil) -> Promise<[CLLocation]> {
        let manager = LocationManager(satisfying: block)
        manager.delegate = manager
        yield(manager)
        manager.startUpdatingLocation()
        _ = manager.promise.ensure {
            manager.stopUpdatingLocation()
        }
        return manager.promise
    }
}

private class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    let (promise, seal) = Promise<[CLLocation]>.pending()
    let satisfyingBlock: ((CLLocation) -> Bool)?

    @objc fileprivate func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let block = satisfyingBlock {
            let satisfiedLocations = locations.filter(block)
            if satisfiedLocations.count > 0 {
                seal.fulfill(satisfiedLocations)
            }
        } else {
            seal.fulfill(locations)
        }
    }

    init(satisfying block: ((CLLocation) -> Bool)? = nil) {
        self.satisfyingBlock = block
    }

    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let (domain, code) = { ($0.domain, $0.code) }(error as NSError)
        if code == CLError.locationUnknown.rawValue && domain == kCLErrorDomain {
            // Apple docs say you should just ignore this error
        } else {
            seal.reject(error)
        }
    }
}


#if os(iOS) || os(watchOS)

extension CLLocationManager {
    /// request CoreLocation authorization from user
    /// NOTE if you want to do whenInUse -> always upgrades then you must specify the auth-type yourself.
    @available(iOS 8, *)
    public class func requestAuthorization(type: RequestAuthorizationType = .automatic) -> Guarantee<CLAuthorizationStatus> {
        return AuthorizationCatcher(auther: auther(type), type: type).promise
    }
}

@available(iOS 8, *)
private class AuthorizationCatcher: CLLocationManager, CLLocationManagerDelegate {
    let (promise, fulfill) = Guarantee<CLAuthorizationStatus>.pending()
    var retainCycle: AuthorizationCatcher?
    let initialAuthorizationState = CLLocationManager.authorizationStatus()

    init(auther: (CLLocationManager) -> Void, type: CLLocationManager.RequestAuthorizationType) {
        super.init()
        switch (initialAuthorizationState, type) {
        case (.authorizedWhenInUse, .always), (.authorizedWhenInUse, .automatic):
            if #available(iOS 11.0, tvOS 100.0, watchOS 100.0, macOS 100.0, *) {
                fallthrough
            }
        case (.notDetermined, _):
            delegate = self
            auther(self)
            retainCycle = self
        default:
            fulfill(initialAuthorizationState)
        }
        promise.done { _ in
            self.retainCycle = nil
        }
    }

    @objc fileprivate func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // `didChange` is a lie; it fires this immediately with the current status.
        if status != initialAuthorizationState {
            fulfill(status)
        }
    }
}

private func auther(_ requestAuthorizationType: CLLocationManager.RequestAuthorizationType) -> ((CLLocationManager) -> Void) {

    //PMKiOS7 guard #available(iOS 8, *) else { return }
    return { manager in
        func hasInfoPlistKey(_ key: String) -> Bool {
            let value = Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
            return !value.isEmpty
        }

        switch requestAuthorizationType {
        case .automatic:
            let always = hasInfoPlistKey("NSLocationAlwaysUsageDescription") || hasInfoPlistKey("NSLocationAlwaysAndWhenInUseUsageDescription")
            let whenInUse = { hasInfoPlistKey("NSLocationWhenInUseUsageDescription") }
            if always {
                manager.requestAlwaysAuthorization()
            } else {
                if !whenInUse() { NSLog("PromiseKit: Warning: `NSLocationAlwaysAndWhenInUseUsageDescription` key not set") }
                manager.requestWhenInUseAuthorization()
            }
        case .whenInUse:
            manager.requestWhenInUseAuthorization()
            break
        case .always:
            manager.requestAlwaysAuthorization()
            break

        }
    }
}

#else

private func auther(_ requestAuthorizationType: CLLocationManager.RequestAuthorizationType) -> (CLLocationManager) -> Void {
    return { _ in }
}

#endif

#endif
