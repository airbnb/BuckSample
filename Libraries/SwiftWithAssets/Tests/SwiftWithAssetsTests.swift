import XCTest

@testable import SwiftWithAssets

final class SomeSwift3Tests: XCTestCase {

  func test_buckImageExists() {
    _ = Catalog.buck.image
    // The above line will crash if the image does not exist.
  }

}
