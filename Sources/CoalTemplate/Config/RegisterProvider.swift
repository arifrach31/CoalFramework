//
//  RegisterProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 31/10/24.
//

import CoalCore

class RegisterProvider: RegisterConfigProvider {
  func getConfig() -> RegisterConfig {
    return RegisterConfig(
      header: ConfigHeader(title: "Register",
                           description: "Register Your Account")
    )
  }
}
