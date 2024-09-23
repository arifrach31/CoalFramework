//
//  String.swift
//
//
//  Created by ArifRachman on 23/09/24.
//

import Foundation

public extension String {
  var isValidURL: Bool {
    if let url = URL(string: self) {
      return url.scheme == "http" || url.scheme == "https"
    }
    return false
  }
}
