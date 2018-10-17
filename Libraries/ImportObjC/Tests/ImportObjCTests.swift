//
//  BuckSampleTests.swift
//  BuckSampleTests
//
//  Created by steven_hepting on 10/12/18.
//  Copyright © 2018 Company. All rights reserved.
//

import XCTest
@testable import ImportObjC

class ImportObjCTests: XCTestCase {

    func testPublicVar() {
        Hello.say("TestName")
    }

    func testCreation() {
        XCTAssertNotNil(Hello())
        XCTAssertNotNil(A())
        XCTAssertNotNil(B())
    }

    func testValue() {
        XCTAssertEqual(A.helloString("testName"), "Hello testName\n")
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(1 == 1);
    }

}
