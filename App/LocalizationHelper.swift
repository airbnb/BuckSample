// Created by Michael Bachand on 5/11/19.
// Copyright © 2019 Airbnb Inc. All rights reserved.

import Foundation

func localizedString(_ key: String, _ comment: String) -> String {
  return NSLocalizedString(key, tableName: "ExampleApp", comment: comment)
}
