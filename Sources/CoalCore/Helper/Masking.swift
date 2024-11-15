//
//  Masking.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation

public func maskingField(_ input: String, type: ConfigFieldType) -> String {
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
  case .text:
    let emailPattern = #"(^.)(.*?)(.@.)(.*)(..)(.*)$"#
    let phonePattern = #"(\d{3})(\d+)(\d{4})$"#
    
    if let emailRegex = try? NSRegularExpression(pattern: emailPattern),
       emailRegex.firstMatch(in: input, options: [], range: NSRange(input.startIndex..<input.endIndex, in: input)) != nil {
      return emailRegex.stringByReplacingMatches(
        in: input,
        options: [],
        range: NSRange(input.startIndex..<input.endIndex, in: input),
        withTemplate: "$1*****$3$4**$6"
      )
    }
    
    if let phoneRegex = try? NSRegularExpression(pattern: phonePattern),
       phoneRegex.firstMatch(in: input, options: [], range: NSRange(input.startIndex..<input.endIndex, in: input)) != nil {
      return phoneRegex.stringByReplacingMatches(
        in: input,
        options: [],
        range: NSRange(input.startIndex..<input.endIndex, in: input),
        withTemplate: "$1*****$3"
      )
    }
    
    return input
  default:
    return ""
  }
}

public func Validator(_ input: String, type: ConfigFieldType, isRequired: Bool = false, minLength: Int? = nil, maxLength: Int? = nil, passwordToMatch: String? = nil) -> Bool {
  if isRequired && input.isEmpty {
    return false
  }
  
  if let minLength = minLength, input.count < minLength {
    return false
  }
  
  if let maxLength = maxLength, input.count > maxLength {
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
  case .confirmPassword:
    let passwordPattern = "^.{8,}$"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
    let isValidPassword = passwordPredicate.evaluate(with: input)
    
    if let passwordToMatch = passwordToMatch {
      return isValidPassword && input == passwordToMatch
    }
    return isValidPassword
  case .text:
    return !input.isEmpty || !isRequired
  case .phone:
    return !input.isEmpty || !isRequired
  default:
    return false
  }
}
