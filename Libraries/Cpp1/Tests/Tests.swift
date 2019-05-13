import XCTest
@testable import Cpp1

final class Cpp1Tests: XCTestCase {
    func testCpp1() {
        XCTAssertEqual(Cpp1.add(1, 2), 3)

        let cppObj = Cpp1()
        XCTAssertEqual(cppObj.add(1, 2), 3)
    }
}
