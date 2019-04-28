// Created by Michael Bachand on 4/27/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import Foundation

@available(iOS 12.0, *)
final class BuckPhotoIntentHandler: NSObject, BuckPhotoIntentHandling {

  func confirm(
    intent: BuckPhotoIntent,
    completion: @escaping (BuckPhotoIntentResponse) -> Void)
  {
    // In a real app, you would probably want to do some check here to make sure you're ready.
    completion(BuckPhotoIntentResponse(code: .ready, userActivity: nil))
  }

  func handle(intent: BuckPhotoIntent, completion: @escaping (BuckPhotoIntentResponse) -> Void) {
    completion(BuckPhotoIntentResponse(code: .success, userActivity: nil))
  }
}
