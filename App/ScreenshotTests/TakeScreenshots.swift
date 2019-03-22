import XCTest
@testable import ExampleApp
import Screenshotter
import UIKit

class TakeScreenshots: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testTakeScreenshots() {
      let viewController = ViewController() // From ExampleApp

      let viewControllersToTest = [viewController]

      let screenshotter = Screenshotter()

      let images = viewControllersToTest.map { screenshotter.imageFromViewController($0) }

      images.map { print($0) /* save to disk or upload */ }
    }
}
