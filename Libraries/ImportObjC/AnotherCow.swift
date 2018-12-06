import Foundation

@objc public class AnotherCow: NSObject {
    @objc public class func say(_ name: String) {
        A.sayHello(name)
        B.sayHi(name)
    }
}
