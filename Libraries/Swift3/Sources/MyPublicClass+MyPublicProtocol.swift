//
//  MyPublicClass+MySecondPublicProtocol.swift
//  Swift3
//
//  Created by Michael Bachand on 2/6/19.
//

import Foundation
import Swift4

extension MyPublicClass: MyPublicProtocol {
  public var currrentThought: String {
    return "This should be visible in the main module!"
  }
}
