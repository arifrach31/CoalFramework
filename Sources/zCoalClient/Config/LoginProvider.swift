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
      loginHeader: ConfigHeader(
        title: "Login",
        description: "Login Description",
        image: "telkom"
      ),
      loginFields: getLoginFields(for: .email),
      additionalButtonConfig: AdditionalButtonConfig(isVisible: true, text: "Forgot Username & Password?"),
      verificationMethods: getVerificationMethods(),
      verificationMethodHeader: ConfigHeader(
        title: "Select Verification Methods",
        description: "Choose one of the methods below to get a verification code."),
      showHome: false
    )
  }
  
  func getLoginFields(for type: LoginType) -> [ConfigField] {
    switch type {
    case .email:
      return [
        ConfigField(type: .email, label: "Emailp", placeholder: "Enter your emailp"),
        ConfigField(type: .password, label: "Passwordp", placeholder: "Enter your passwordp"),
        ConfigField(type: .submit, label: "Login", backgroundColor: Color.mainBackground.toHex())
      ]
    case .phone:
      return [
        ConfigField(type: .phone, label: "Phone", placeholder: "Enter your phone number"),
        ConfigField(type: .submit, label: "Login")
      ]
    }
  }
  
  func getVerificationMethods() -> [ConfigField] {
    return [
      ConfigField(type: .email, label: "arifrach31@gmail.com"),
      ConfigField(type: .phone, label: "082111113184")
    ]
  }
}
