//
//  ChangePasswordProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 04/11/24.
//

import CoalCore

class ChangePasswordProvider: ChangePasswordConfigProvider {
  func getConfig() -> ChangePasswordConfig {
    return ChangePasswordConfig(
      header: ConfigHeader(title: "Change Password",
                           description: "Please enter registered email address or mobile number in your account to change the password.",
                           image: "garuda"),
      fields: changePasswordFields()
    )
  }
  
  func changePasswordFields() -> [ConfigField] {
    return [
      ConfigField(type: .password, label: "PasswordMu", placeholder: "Enter your password"),
      ConfigField(type: .confirmPassword, label: "Confirm PasswordMu", placeholder: "Enter your confirm password"),
      ConfigField(type: .submit, label: "Change Password")
    ]
  }
}
