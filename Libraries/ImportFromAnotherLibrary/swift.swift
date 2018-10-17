import Foundation

import ImportObjC

@objc public class Swift : NSObject {
    public class func say(name: String) {
        A.sayHello(name)
        B.sayHi(name)
    }
}
