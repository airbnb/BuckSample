import XCTest

@testable import SwiftUsedByAppAndWatch

final class SwiftUsedByAppAndWatchTests: XCTestCase {

  func test_savingValue() {
    let sut = PseudoKeyValueStore()
    let key = "🔑"
    sut.save(1, forKey: key)

    if let value = sut.retrieveValueForKey(key) as? Int {
      XCTAssertEqual(1, value)
    }
    else {
      XCTFail()
    }
  }
}
