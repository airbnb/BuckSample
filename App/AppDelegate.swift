import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let window = UIWindow(frame: UIScreen.main.bounds)

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    window.makeKeyAndVisible()
    window.rootViewController = ViewController()

    return true
  }
}
