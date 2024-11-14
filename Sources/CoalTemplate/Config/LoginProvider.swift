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
      header: ConfigHeader(title: "Login",
                           description: "Login Description",
                           image: "garuda"),
      fields: ConfigDefault.loginFields(for: .email),
      additionalButtonConfig: AdditionalButtonConfig(
        isVisible: true,
        text: "Forgot Username & Password?",
        actionScreen: .forgot
      ),
      loginButtonAction: .swiftui(ClientView())
    )
  }
}
