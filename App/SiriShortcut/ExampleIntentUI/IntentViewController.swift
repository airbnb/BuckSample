// Created by Michael Bachand on 4/20/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import IntentsUI

#if swift(>=4.0)
final class IntentViewController: UIViewController, INUIHostedViewControlling {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .gray
    // Do any additional setup after loading the view.
  }

  // Prepare your view controller for the interaction to handle.
  func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
    // Do configuration here, including preparing views and calculating a desired size for presentation.
    completion(true, parameters, self.desiredSize)
  }

  var desiredSize: CGSize {
    guard let hostedViewMaximumAllowedSize = extensionContext?.hostedViewMaximumAllowedSize else {
      fatalError("Unexpectedly could no extension context")
    }
    var result = hostedViewMaximumAllowedSize
    result.height = 400
    return result
  }

}
#endif
