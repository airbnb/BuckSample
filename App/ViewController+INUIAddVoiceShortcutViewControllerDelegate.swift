// Created by Michael Bachand on 4/27/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import IntentsUI
import UIKit

#if !DISABLE_SIRI_SHORTCUT
@available(iOS 12.0, *)
extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {

  func addVoiceShortcutViewController(
    _ controller: INUIAddVoiceShortcutViewController,
    didFinishWith voiceShortcut: INVoiceShortcut?,
    error: Error?)
  {
    controller.dismiss(animated: true)
  }

  func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
    controller.dismiss(animated: true)
  }
}
#endif
