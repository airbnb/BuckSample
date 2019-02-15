import Foundation

public class MyBridgedSwiftClassInMixedModule: NSObject {

  public func findObjectiveCInstance() -> Any {
    // Prove that Swift can find Objective C code in this module without a bridging header.
    return MyBridgedObjcClassInMixedModule()
  }

}
