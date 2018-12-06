import Foundation
import ImportObjC

/*
 ______________________________________
< https://en.wikipedia.org/wiki/Cowsay >
 --------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
*/

@objc public class Cow: NSObject {
    public class func say(name: String) {
        A.sayHello(name)
        B.sayHi(name)
    }
}
