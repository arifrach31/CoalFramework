//
//  VerificationProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 22/10/24.
//

import CoalCore

class VerificationProvider: VerificationConfigProvider {
  func getConfig() -> VerificationConfig {
    return VerificationConfig(
      verificationMethodHeader: ConfigHeader(
        title: "Select Verification Methods",
        description: "Choose one of the methods below to get a verification code.",
        image: "garuda"
      ),
      verificationCodeHeader: ConfigHeader(
        title: "Enter Verification Code",
        description: "The verification code has been sent to"
      ),
      verificationField: verificationField()
    )
  }
  
  private func verificationField() -> ConfigField {
    return ConfigField(type: .submit, label: "Submit", backgroundColor: Color.mainBackground.toHex())
  }
}
