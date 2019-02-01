import XCTest

@testable import SwiftWithAssets

final class SomeSwift3Tests: XCTestCase {

  func test_buckImageExists() {
    XCTAssertNotNil(Catalog.buck.image)
  }

}
