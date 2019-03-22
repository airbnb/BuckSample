import XCTest
@testable import ExampleApp
import Screenshotter
import UIKit

class TakeScreenshots: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func viewControllersToTest() -> [UIViewController] {
      let backgroundColors: [UIColor] = [.red, .green, .blue]
      return backgroundColors.map { color in
        let viewController = ViewController() // From ExampleApp
        let view = viewController.view
        view.backgroundColor = .red
        // iPhone X dimensions
        view.frame.size = CGSize(width: 1125, height: 2436)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        return viewController
      }
    }

    func testTakeScreenshots() {
      let screenshotter = Screenshotter()
      let images = viewControllersToTest().map { screenshotter.imageFromViewController($0) }
      images.map { print("Image: \($0)" /* save to disk or upload */ }
    }
}
