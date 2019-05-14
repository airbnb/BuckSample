//
//  BuckSampleUITests.swift
//  BuckSampleUITests
//
//  Created by steven_hepting on 10/12/18.
//

import XCTest

class BuckSampleUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExampleAppLabel() {
        XCTAssertEqual(app.label, "ExampleApp")
    }

    func testMainScreenLabelExists() {
        XCTAssert(app.staticTexts["Hello, world"].exists)
    }
}
