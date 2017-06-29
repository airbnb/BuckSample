import Foundation

@objc public class Hello : NSObject {
    public class func say(name: String) {
        A.sayHello(name)
        B.sayHi(name)
    }
}
