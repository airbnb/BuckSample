import XCTest

@testable import SwiftWithAssets

final class SwiftWithAssetsTests: XCTestCase {

  func test_buckImageExists() {
    XCTAssertNotNil(Catalog.buck.image)
  }

}
