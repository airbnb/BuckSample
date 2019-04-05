import XCTest
@testable import ASwiftModule

final class SomeASwiftModuleTests: XCTestCase {

  func testMySwiftClassAdding() {
    let sut = MySwiftClass()
    XCTAssertEqual(sut.add(1, 2), 3)
  }

}
