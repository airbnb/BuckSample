import UIKit


#if swift(>=4.0)
typealias ArgType = [UIApplication.LaunchOptionsKey: Any]?
#else
typealias ArgType = [UIApplicationLaunchOptionsKey : Any]?
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let window = UIWindow(frame: UIScreen.main.bounds)

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: ArgType) -> Bool {

    window.makeKeyAndVisible()
    window.rootViewController = ViewController()

    return true
  }

  #if !DISABLE_SIRI_SHORTCUT
  #if swift(>=4.2)
  // Xcode 10
  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
  {
    return continueWithUserActivity(userActivity)
  }
  #endif
  #endif

  // MARK: Private

  private func continueWithUserActivity(_ userActivity: NSUserActivity) -> Bool {
    guard #available(iOS 12.0, *) else {
      return false
    }

    #if !DISABLE_SIRI_SHORTCUT
    if let buckPhotoIntent = userActivity.interaction?.intent as? BuckPhotoIntent {
      print("Launched with BuckPhotoIntent: \(buckPhotoIntent)")
      return true
    } else {
      return false
    }
    #else
    return false
    #endif
  }
}
