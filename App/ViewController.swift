import UIKit
import ASwiftModule
import SecondSwiftModule
import YetAnotherSwiftModule
import CryptoSwift
import Objc1
import ObjcAndSwift
import PromiseKit
import SwiftAndObjc
import SwiftReliesOnCXX
import SwiftWithAssets
import SwiftWithMLModel
import Cpp1

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

    // Swift class defined in ASwiftModule
    let s = MySwiftClass()
    print("ASwiftModule: \(s)")

    // Swift class defined in SecondSwiftModule. This class is bridged to Objective-C by subclassing `NSObject`
    // and using the `@objc` annotation.
    let c = Counter()
    print("SecondSwiftModule: \(c)")
    c.increment()

    // From CryptoSwift
    let data = Data(bytes: [0x01, 0x02, 0x03])
    print("Crypto: \(data)")

    // Objective-C class defined in Objc1
    let o = Objc1()
    print("Objc1: %s", o)
    Objc1.sayHello("Michael")
    
    // C++ wrapped in Objective-C class defined in Cpp1
    let cpp = Cpp1()
    print("class method:  1 + 2 =", cpp.add(1, with: 2))
    print("static method: 1 + 2 =", Cpp1.add(1, with: 2))
    MySwiftClassInCxxModule().bestowGreetings("Hello from the Cxx world")
    print("I can see \(MyBridgedSwiftClassInCxxModule().findObjectiveCInstance())")

    // Swift class defined in SwiftAndObjc
    SwiftAndObjc.MySwiftClassInMixedModule().bestowGreetings("Hello world, how are you?")
    // Objective-C class defined in SwiftAndObjc
    SwiftAndObjc.MyObjcClassInMixedModule().sayHello("George")

    // Swift class defined in ObjcAndSwift
    print("I can see \(ObjcAndSwift.MyBridgedSwiftClassInMixedModule().findObjectiveCInstance())")

    // Swift class imports a library with Objective-C++
    MySwiftReliesOnCXXClass().doSomethingWithCXXLibrary()

    // This line will crash if the assets from SwiftWithAssets haven't been bundled into the app
    _ = Catalog.buck.image

    // Without an object explicitly typed as `MyPublicClass` in this module, an instance of
    // `MyPublicClass` won't exhibit conformance to `MyPublicProtocol`. `MyPublicClass` is defined
    // in `YetAnotherSwiftModule`. `MyPublicProtocol` and the conformance of `MyPublicClass` to `MyPublicProtocol`
    // is defined in `SecondSwiftModule`.
    //
    // We are currently working around this issue in the Buck-generated project by including the
    // `-all_load` flag for `OTHER_LDFLAGS` in the `configs` that we are passing to all
    // `apple_binary()` invocations.
    //
    // Other known workarounds:
    // * Annotate `MyPublicProtocol` with `@objc` and pass the `-ObjC` flag to `OTHER_LDFLAGS`.
    // * Annotate the conformance of `MyPublicClass` to `MyPublicProtocol` with `@objc` and pass
    // the `-ObjC` flag to `OTHER_LDFLAGS`.
    // * `-force_load` the module where the conformance exists. In this case that would be `SecondSwiftModule`.
    //
    // This bug is documented at https://bugs.swift.org/browse/SR-6004.
    let myObject = MyFactory.myPublicObject()
    if (myObject as? MyPublicProtocol) == nil {
      print("Incorrect: `MyPublicProtocol` conformance is being erroneously stripped")
    } else {
      print("Correct: `MyPublicProtocol` conformance is not being stripped")
    }

    print("Building a habitat on mars would cost you $\(MarsHabitatPriceFinder().predictedPrice(solarPanels: 5, greenhouses: 10, size: 50))")

    print("All good!")

    // From PromiseKit
    let promise = Promise<String> { seal in
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        seal.fulfill("Hello from PromiseKit")
      }
    }
    promise.done { (value) in
      print(value)
      }.catch { (error) in
        print(error)
    }
  }
}
