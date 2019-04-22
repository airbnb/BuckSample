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


  #if swift(>=4.2)
  // Xcode 10
  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
  {
    return continueWithUserActivity(userActivity)
  }
  #else
  // Xcode 9
  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([Any]?) -> Void) -> Bool
  {
    return continueWithUserActivity(userActivity)
  }
  #endif

  // MARK: Private

  private func continueWithUserActivity(_ userActivity: NSUserActivity) -> Bool {
    if #available(iOS 12.0, *) {
      let maybeIntent: Any = "this_will_not_work"
      guard let intent = maybeIntent as? BuckPhotoIntent else {
        print("Not a valid intent")
        return false
      }
      _ = intent
      return true
    }
    else {
      return false
    }
  }
}
