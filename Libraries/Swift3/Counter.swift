import Swift4

public class Counter {

  public init() { }

  public private(set) var value: Int = 0

  public func increment() {
    let oldValue = value
    value = oldValue + 1
    logger.log("Incremented value from \(oldValue) to \(value)")
  }

  private let logger = Logger()
}
