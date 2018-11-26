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
    Hello.say("Jim") // ImportObjC
    Swift.say(name: "Bobby") // ImportFromAnotherLibrary
    objC.callSwift(byName: "Tom") // ImportFromAnotherLibrary
  }

}
