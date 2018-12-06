import UIKit

import ImportObjC
import ImportFromAnotherLibrary

public let testVar = "SampleValue"

class ViewController: UIViewController {

  let value = "ViewName"

  override func viewDidLoad() {
    super.viewDidLoad()

    let view = UIView()
    view.frame = self.view.frame
    view.backgroundColor = .gray
    self.view = view

    let label = UILabel()
    label.text = "Main Screen"
    self.view.addSubview(label)
    label.sizeToFit()
    label.center = self.view.center
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Swift class defined in ImportObjC
    AnotherCow.say("Jim")

    // Swift class defined in ImportFromAnotherLibrary
    Cow.say(name: "Bobby")

    // Objective-C class defined in ImportFromAnotherLibrary
    objC.callSwift(byName: "Tom")
  }
}
