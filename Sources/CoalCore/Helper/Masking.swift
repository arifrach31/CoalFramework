//
//  Masking.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation

public enum MaskingType {
  case email, phone
}

public func maskingAccount(_ input: String, type: MaskingType) -> String {
  switch type {
  case .email:
    let emailPattern = #"(^.)(.*?)(.@.)(.*)(..)(.*)$"#
    guard let regex = try? NSRegularExpression(pattern: emailPattern) else {
      return input
    }
    return regex.stringByReplacingMatches(
      in: input,
      options: [],
      range: NSRange(input.startIndex..<input.endIndex, in: input),
      withTemplate: "$1*****$3$4**$6"
    )
  case .phone:
    let phonePattern = #"(\d{3})(\d+)(\d{4})$"#
    guard let regex = try? NSRegularExpression(pattern: phonePattern) else {
      return input
    }
    return regex.stringByReplacingMatches(
      in: input,
      options: [],
      range: NSRange(input.startIndex..<input.endIndex, in: input),
      withTemplate: "$1*****$3"
    )
  }
}
