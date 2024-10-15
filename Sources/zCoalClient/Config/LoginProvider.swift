//
//  LoginProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 14/10/24.
//

import CoalCore

class LoginProvider: LoginConfigProvider {
  func getConfig() -> LoginConfig {
    return LoginConfig(backgroundImageName: "background",
                       loginHeader: ConfigHeader(title: "Login",
                                                 description: "Login Description",
                                                 image: "garuda"),
                       loginFields: getLoginFields(for: .email),
                       forgotButtonConfig: ForgotButtonConfig(isVisible: true, text: "Forgot Username & Password?"))
  }
  
  func getLoginFields(for type: LoginType) -> [ConfigField] {
    switch type {
    case .email:
      return [
        ConfigField(type: .email, label: "Emailp", placeholder: "Enter your emailp"),
        ConfigField(type: .password, label: "Passwordp", placeholder: "Enter your passwordp"),
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
