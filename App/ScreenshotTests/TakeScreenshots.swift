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

      let images = viewControllersToTest.map { |vc| screenshotter.imageFromViewController() }

      images.map { |vc| /* upload or save to disk */ }
    }
}
