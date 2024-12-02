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
      backgroundImage: "background",
      backgroundColor: "#00a1dd",
      header: ConfigHeader(
        title: "Login yaa",
        description: "Login Description",
        image: "garuda"
      ),
      fields: loginFields()
      forgotButton: ForgotButton(
        isVisible: true,
        text: "Forgot Username & Password?"
      ),
      verificationEnabled: false,
      loginButtonAction: .swiftui(ClientView())
    )
  }
  
  func loginFields() -> [ConfigField] {
    return [
      ConfigField(type: .email, label: "Email", placeholder: "Enter your email", errorMessage: "Oyy, email lu salah tuu!", isShowError: true),
      ConfigField(type: .password, label: "Password", placeholder: "Enter your password"),
      ConfigField(type: .submit, label: "Login")
    ]
  }
}
