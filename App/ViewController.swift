import UIKit
import Swift2
import Swift3
import CryptoSwift
import Objc1
import SwiftAndObjc
import SwiftReliesOnCXX
import SwiftWithAssets

public let testVar = "SampleValue"

class ViewController: UIViewController {

  let value = "ViewName"

  override func viewDidLoad() {
    super.viewDidLoad()

    let view = UIView()
    view.frame = self.view.frame
    view.backgroundColor = .gray
    self.view = view

    let label = UILabel()
    label.text = "Main Screen"
    self.view.addSubview(label)
    label.sizeToFit()
    label.center = self.view.center
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Swift class defined in Swift2
    let s = MySwiftClass()
    print("Swift2: \(s)")

    // Swift class defined in Swift3. This class is bridged to Objective-C by subclassing `NSObject`
    // and using the `@objc` annotation.
    let c = Counter()
    print("Swift3: \(c)")
    c.increment()

    // From CryptoSwift
    let data = Data(bytes: [0x01, 0x02, 0x03])
    print("Crypto: \(data)")

    // Objective-C class defined in Objc1
    let o = Objc1()
    print("Objc1: %s", o)
    Objc1.sayHello("Michael")

    // Swift class defined in SwiftAndObjc
    MySwiftClassInMixedModule().bestowGreetings("Hello world, how are you?")
    // Objective-C class defined in SwiftAndObjc
    MyObjcClassInMixedModule().sayHello("George")

    // Swift class imports a library with Objective-C++
    MySwiftReliesOnCXXClass().doSomethingWithCXXLibrary()

    // This line will crash if the assets haven't been bundled into the app
    _ = Catalog.buck.image

    print("All good!")
  }
}
