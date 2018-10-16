//
//  ViewController.swift
//  BuckSample
//
//  Created by steven_hepting on 10/12/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  public let value = "ViewName"

  // override func viewDidLoad() {
  //   super.viewDidLoad()
  //   // Do any additional setup after loading the view, typically from a nib.

  //   let view = UIView()
  //   view.backgroundColor = .blue
  //   self.view = view
    
  // }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let view = UIView()
    view.bounds = UIScreen.main.bounds
    view.backgroundColor = .blue
    self.view = view

  }


}

