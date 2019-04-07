import Foundation

public class MyBridgedSwiftClassInCxxModule: NSObject {

  public func findObjectiveCInstance() -> Any {
    return Cpp1()
  }
}
