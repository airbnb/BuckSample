import UIKit


#if swift(>=4.2)
typealias ArgType = [UIApplication.LaunchOptionsKey: Any]? // Xcode 10
#else
typealias ArgType = [UIApplicationLaunchOptionsKey : Any]? // Xcode 9
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let window = UIWindow(frame: UIScreen.main.bounds)

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: ArgType) -> Bool {
  
    window.makeKeyAndVisible()
    window.rootViewController = ViewController()

    return true
  }
}
