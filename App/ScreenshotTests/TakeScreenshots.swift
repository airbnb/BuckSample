@testable import ExampleApp

import Foundation
import Screenshotter
import UIKit
import XCTest

// MARK: - TakeScreenshots

final class TakeScreenshots: XCTestCase {

  // MARK: Internal

  override func setUp() {
    setUpImagesDirectory()
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

  // MARK: Private

  private let fileManager = FileManager.default

  private lazy var urlForImagesDirectory: URL = {
    guard let documentsURL = FileManager.default.urls(
      for: .documentDirectory,
      in: .userDomainMask).first else
    {
      preconditionFailure("Cannot find Documents URL")
    }

    return documentsURL.appendingPathComponent("ScreenshotTests", isDirectory: true)
  }()

  /// Deletes the images directory if it exists. Creates the images directory.
  private func setUpImagesDirectory() {
    var isDirectory: ObjCBool = true
    let directoryExists = fileManager.fileExists(
      atPath:  urlForImagesDirectory.absoluteString,
      isDirectory: &isDirectory)

    if directoryExists {
      do {
        try fileManager.removeItem(at: urlForImagesDirectory)
      }
      catch {
        fatalError("Unable to remove \(urlForImagesDirectory.absoluteString): \(error)")
      }
    }

    do {
      try fileManager.createDirectory(
        at: urlForImagesDirectory,
        withIntermediateDirectories: true,
        attributes: nil)
    }
    catch {
      fatalError("Unable to create \(urlForImagesDirectory.absoluteString): \(error)")
    }
  }

  private func storeImage(_ image: UIImage) {
    print(urlForImagesDirectory.absoluteString)
  }
}
