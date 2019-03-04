//
//  BuckSampleTests.swift
//  BuckSampleTests
//
//  Created by steven_hepting on 10/12/18.
//

import XCTest
@testable import ExampleApp

final class BuckSampleTests: XCTestCase {

    func testViewController() {
        // This test accesses internal classes and properties in the ExampleApp library.
        let sut = ViewController()
        XCTAssertEqual(sut.value, "ViewName")
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
