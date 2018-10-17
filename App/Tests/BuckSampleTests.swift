//
//  BuckSampleTests.swift
//  BuckSampleTests
//
//  Created by steven_hepting on 10/12/18.
//  Copyright © 2018 Company. All rights reserved.
//

import XCTest
@testable import ExampleAppLibrary

class BuckSampleTests: XCTestCase {

    override func setUp() {

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation() {
        XCTAssertNotNil(ViewController())
    }

    func testValue() {
        XCTAssertEqual(ViewController().value, "ViewName")
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
