import Foundation

/// This is an in-memory key-value store.
public final class PseudoKeyValueStore {

  // MARK: Lifecycle

  public init() { }


  // MARK: Public

  func save(_ value: Any, forKey key: String) {
    data[key] = value
  }

  func retrieveValueForKey(_ key: String) -> Any? {
    return data[key]
  }

  // MARK: Internal

  var data = Dictionary<String, Any>()
}
