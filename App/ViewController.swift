import UIKit
import Swift3
import CryptoSwift
import Objc1

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


    // Swift class defined in Swift3. This class is bridged to Objective-C by subclassing `NSObject`
    // and using the `@objc` annotation.
    let c = Counter()
    print("Swift3: \(c)")
    c.increment()

    // From CryptoSwift
    let data = Data(bytes: [0x01, 0x02, 0x03])
    print("Crypto: \(data)")

    // Objective C class defined in Objc1
    let o = Objc1()
    print("Objc1: %s", o)

    // Swift class defined in SwiftAndObjc
    //
    // When this is used, the compile fails with
    //    #import <SwiftAndObjc/SwiftAndObjc-Swift.h> file not found
    //
    // To see this for yourself, do the following:
    // - Uncomment the following line of code.
    // - Add `import SwiftAndObjc` to the top of this file.
    // - Add "//Libraries/SwiftAndObjc:SwiftAndObjc" as a dependency of `Swift1` in the BUCK file.
    // - Regenerate this project and build.
//     print("SwiftAndObjc \(Swift3())")
  }
}
