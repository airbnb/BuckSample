import Fabric

public class SwiftWithPrecompiledDependencyClass {

  public static var isFabricInDebugMode: Bool {
    return Fabric.sharedSDK().debug
  }
  
}
