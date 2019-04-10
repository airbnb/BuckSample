import XCTest

@testable import SwiftWithPrecompiledDependency

final class SwiftWithPrecompiledDependencyTests: XCTestCase {

  func test_canAccessAFNetworking() {
    XCTAssertNotEqual(SwiftWithPrecompiledDependencyClass.networkingLibraryVersionNumber, 0)
  }

}
