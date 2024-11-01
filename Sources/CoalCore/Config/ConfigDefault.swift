//
//  ConfigDefault.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import Foundation

public struct ConfigDefault {
  public static func loginFields(for type: LoginType) -> [ConfigField] {
    switch type {
    case .username:
      return [
        ConfigField(type: .text, label: "Username", placeholder: "Enter your username"),
        ConfigField(type: .password, label: "Password", placeholder: "Enter your password"),
        ConfigField(type: .submit, label: "Login")
      ]
    case .email:
      return [
        ConfigField(type: .email, label: "Your Email", placeholder: "Enter your email"),
        ConfigField(type: .password, label: "Password", placeholder: "Enter your password"),
        ConfigField(type: .submit, label: "Login")
      ]
    case .phone:
      return [
        ConfigField(type: .phone, label: "Phone", placeholder: "Enter your phone number"),
        ConfigField(type: .submit, label: "Login")
      ]
    }
  }
  
  public static func registerFields() -> [ConfigField] {
    return [
      ConfigField(type: .text, label: "Full Name", placeholder: "Enter your full name"),
      ConfigField(type: .email, label: "Email", placeholder: "Enter your email"),
      ConfigField(type: .password, label: "Password", placeholder: "Enter your password"),
      ConfigField(type: .checkbox, label: "Agree to Terms and Conditions", placeholder: nil),
      ConfigField(type: .submit, label: "Register")
    ]
  }
  
  public static var forgotFields: [ConfigField] {
    return [
      ConfigField(type: .email, label: "Email Address / Mobile Number", placeholder: "Enter registered data"),
      ConfigField(type: .submit, label: "Next")
    ]
  }
}
