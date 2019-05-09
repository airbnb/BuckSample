// Created by Michael Bachand on 4/20/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import Intents

class IntentHandler: INExtension {

  override func handler(for intent: INIntent) -> Any {
    if #available(iOS 12.0, *) {
      #if !DISABLE_SIRI_SHORTCUT
      guard intent is BuckPhotoIntent else {
        fatalError("Unhandled intent type: \(intent)")
      }
      #endif
      return BuckPhotoIntentHandler()
    } else {
      fatalError("Unexpectly executing code path on iOS < 12.0")
    }
  }

}
