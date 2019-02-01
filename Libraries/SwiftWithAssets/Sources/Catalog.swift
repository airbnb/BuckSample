import UIKit

public enum Catalog: String {

  case buck

  public var image: UIImage {
    let bundle = Bundle(for: BundleIdentifier.self)
    guard let image = UIImage(named: self.rawValue, in: bundle, compatibleWith: nil) else {
      fatalError("Could not find image named \(self.rawValue) in \(bundle)")
    }
    return image
  }

}

private final class BundleIdentifier {}
