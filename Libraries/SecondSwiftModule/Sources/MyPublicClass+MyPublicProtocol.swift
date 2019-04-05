//
//  MyPublicClass+MySecondPublicProtocol.swift
//  SecondSwiftModule
//
//  Created by Michael Bachand on 2/6/19.
//

import Foundation
import YetAnotherSwiftModule

extension MyPublicClass: MyPublicProtocol {
  public var currrentThought: String {
    return "This should be visible in the main module!"
  }
}
