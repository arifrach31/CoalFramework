//
//  Masking.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation

public func maskingAccount(_ input: String, type: ConfigFieldType) -> String {
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
  default:
    return ""
  }
}

public func Validator(_ input: String, type: ConfigFieldType, isRequired: Bool = false) -> Bool {
  if isRequired && input.isEmpty {
    return false
  }
  
  switch type {
  case .email:
    let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
    return emailPredicate.evaluate(with: input)
  case .password:
    let passwordPattern = "^.{8,}$"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    return passwordPredicate.evaluate(with: input)
  case .text:
    return !input.isEmpty || !isRequired
  default:
    return false
  }
}
