//
//  LoginProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 14/10/24.
//

import CoalCore

class LoginProvider: LoginConfigProvider {
  func getConfig() -> LoginConfig {
    return LoginConfig(
      loginHeader: ConfigHeader(title: "Login",
                                description: "Login Description",
                                image: "garuda"),
      loginFields: getLoginFields(for: .email),
      additionalButtonConfig: AdditionalButtonConfig(isVisible: true, text: "Forgot Username & Password?")
    )
  }
  
  func getLoginFields(for type: LoginType) -> [ConfigField] {
    switch type {
    case .username:
      return [
        ConfigField(type: .text, label: "Username", placeholder: "Enter your username"),
        ConfigField(type: .password, label: "Password", placeholder: "Enter your password"),
        ConfigField(type: .submit, label: "Login")
      ]
    case .email:
      return [
        ConfigField(type: .email, label: "Email", placeholder: "Enter your email"),
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
}
