import XCTest
@testable import Screenshotter
import UIKit

final class ScreenshotterTests: XCTestCase {

  func testCreatingScreenshot() {
    let sut = Screenshotter()
    let viewController = UIViewController()
    XCTAssertNotNil(sut.imageFromViewController(viewController))
  }

}
