import XCTest
@testable import SwiftWithPrecompiledDependency

final class SwiftWithPrecompiledDependencyTests: XCTestCase {

  func testCanAccessFabric() {
    XCTAssertFalse(SwiftWithPrecompiledDependencyClass.isFabricInDebugMode)
  }

}
