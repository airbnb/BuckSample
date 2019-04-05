import XCTest

@testable import SwiftWithPrecompiledDependency

final class SwiftWithPrecompiledDependencyTests {

  func test_canAccessAFNetworking() {
    XCTAssertNotEqual(SwiftWithPrecompiledDependencyClass.networkingLibraryVersionNumber, 0)
  }

}
