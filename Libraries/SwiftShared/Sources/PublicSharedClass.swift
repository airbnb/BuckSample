//
//  Created by Qing Yang on 3/13/19.
//  Copyright © 2019 Airbnb. All rights reserved.
//

import Foundation

public class PublicSharedClass {
  public init () {
  }

  public func readFromResource() -> String {
    if let filepath = Bundle(identifier: "com.airbnb.SwiftSharedFramework")?.path(forResource: "plaintext", ofType: "txt"),
       let content = try? String(contentsOfFile: filepath) {
      return content
    } else {
      return "Not Found!"
    }
  }
}
