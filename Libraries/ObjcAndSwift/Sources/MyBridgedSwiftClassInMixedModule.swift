import Foundation

public class MyBridgedSwiftClassInMixedModule: NSObject {

  public func findObjectiveCInstance() -> Any {
    // Prove that Swift can find Objective C code in this module without a bridging header.
    // Bridging headers aren't needed in library modules, since the umbrella header effectively acts as a bridging header.
    return MyBridgedObjcClassInMixedModule()
  }

}
