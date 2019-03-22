import XCTest
@testable import ExampleApp
import Screenshotter
import UIKit

// MARK: - TakeScreenshots

final class TakeScreenshots: XCTestCase {

  // MARK: Internal

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

    func viewControllersToTest() -> [UIViewController] {
      let backgroundColors: [UIColor] = [.red, .green, .blue]
      return backgroundColors.map { color in
        let viewController = ViewController() // From ExampleApp
        viewController.view.backgroundColor = color
        return viewController
      }
    }

    func testTakeScreenshots() {
      let screenshotter = Screenshotter()
      let images = viewControllersToTest().map { screenshotter.imageFromViewController($0) }
      for image in images.compactMap({ $0 }) {
        storeImage(image)
      }
    }
  }

  // MARK: Private

  private func storeImage(_ image: UIImage) {
    // TODO(MB): implement
    print("Storing image")
  }
}
