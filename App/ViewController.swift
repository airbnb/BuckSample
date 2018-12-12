import UIKit

//import Objc1
import ImportSwift
import Swift2

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

    // Swift class defined in ImportSwift
    let c = Counter()
    print("Test: %s", c)

    // Swift class defined in Swift2
    let s = SwiftClass2()
    print("Swift2: %s", s)

    // Objective C class defined in Objc1
    // When this is uncommented, LLDB fails to print objects properly
    // with the following error:
    //   failed to get module 'ExampleAppLibrary' from AST context:
    //   error: missing required module 'Objc1'
//    let o = Objc1()
//    print("Objc1: %s", o)
  }
}
