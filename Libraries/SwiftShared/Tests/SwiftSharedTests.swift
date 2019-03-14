import XCTest

@testable import SwiftShared

final class SwiftSharedTests: XCTestCase {
  func test_readResource() {
    let content = PublicSharedClass().readFromResource()
    XCTAssertEqual(content, "Hello, Buck!")
  }
}
