//
//  BuckSampleTests.swift
//  BuckSampleTests
//
//  Created by steven_hepting on 10/12/18.
//

import XCTest
@testable import Swift2

final class BuckSampleTests: XCTestCase {

    func testMySwiftClassAdding() {
        let sut = MySwiftClass()
        XCTAssertEqual(sut.add(1, 2), 3)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(1 == 1);
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
