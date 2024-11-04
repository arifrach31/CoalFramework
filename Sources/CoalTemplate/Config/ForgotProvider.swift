//
//  ForgotProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 01/11/24.
//

import CoalCore

class ForgotProvider: ForgotConfigProvider {
  func getConfig() -> ForgotConfig {
    return ForgotConfig(
      header: ConfigHeader(title: "Forgot Password",
                           description: "Please enter registered email address or mobile number in your account to change the password.",
                           image: "garuda"),
      actionScreen: .changePassword
    )
  }
}
