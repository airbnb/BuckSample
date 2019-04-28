// Created by Michael Bachand on 4/20/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import Intents

class IntentHandler: INExtension {

  override func handler(for intent: INIntent) -> Any {
    if #available(iOSApplicationExtension 12.0, *) {
      guard intent is BuckPhotoIntent else {
        fatalError("Unhandled intent type: \(intent)")
      }
      return BuckPhotoIntentHandler()
    } else {
      fatalError("Unexpectly executing code path on iOS < 12.0")
    }
  }

}
