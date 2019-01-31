import Bugsnag

public class MySwiftReliesOnCXXClass {
  public init() {
    print("Initialized MySwiftReliesOnCXXClass")
  }

  public func doSomethingWithCXXLibrary() {
    Bugsnag.clearBreadcrumbs()
  }
}
