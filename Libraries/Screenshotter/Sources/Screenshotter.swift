import UIKit

public final class Screenshotter {

    // MARK: Lifecyle

    public init() { }

    // MARK: Public

    public func imageFromViewController(_ viewController: UIViewController) -> UIImage? {
      viewController.loadViewIfNeeded()

      guard let view = viewController.view else {
        preconditionFailure("No view")
      }

      // iPhone X dimensions
      let layoutSize = CGSize(width: 1125, height: 2436)
      viewController.view.frame.size = layoutSize

      UIGraphicsBeginImageContextWithOptions(layoutSize, view.isOpaque, 0.0)
      guard let context = UIGraphicsGetCurrentContext() else {
        preconditionFailure("Cannot create context")
      }
      defer { UIGraphicsEndImageContext() }

      view.setNeedsLayout()
      view.layoutIfNeeded()
      view.layer.render(in: context)

      return UIGraphicsGetImageFromCurrentImageContext()
    }
}
