// import Braintree

public class MySwiftClass {
  public init() {
    print("Initialized MySwiftClass")

    // TODO: Comment out Braintree invocation for now until it supports M1 mac: https://github.com/braintree/braintree_ios/issues/564
    // let request =  BTAPIClient(authorization: "testkey")
    // print("Braintree: \(String(describing: request))")
  }

  public func add(_ int1: Int, _ int2: Int) -> Int {
    return int1 + int2
  }
}
