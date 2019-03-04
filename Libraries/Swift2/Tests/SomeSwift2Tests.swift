import XCTest
@testable import Swift2

final class SomeSwift2Tests: XCTestCase {

  func testMySwiftClassAdding() {
    let sut = MySwiftClass()
    XCTAssertEqual(sut.add(1, 2), 3)
  }

}
