//
//  MyFactory.swift
//  YetAnotherSwiftModule
//
//  Created by Michael Bachand on 2/6/19.
//

import Foundation

public class MyFactory {
  /// Returns a type-erased instance of `MyPublicClass`.
  public static func myPublicObject() -> Any {
    return MyPublicClass()
  }
}
