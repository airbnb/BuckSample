import UIKit

#if swift(>=4.2)
typealias ArgType = [UIApplication.LaunchOptionsKey: Any]? // Xcode 10
#else
typealias ArgType = [UIApplicationLaunchOptionsKey : Any]? // Xcode 9
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: ArgType) -> Bool {
    return true
  }
}
