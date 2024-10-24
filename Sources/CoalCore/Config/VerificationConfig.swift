//
//  VerificationConfig.swift
//
//
//  Created by ArifRachman on 22/10/24.
//

import Foundation

public protocol VerificationConfigProvider {
  func getConfig() -> VerificationConfig
}

public class VerificationConfig: BaseConfig {
  public var showVerificationMethod: Bool?
  public var verificationMethodHeader: ConfigHeader?
  public var verificationCodeHeader: ConfigHeader?
  public var sendVerificationCodeTo: ConfigField?
  public var verificationField: ConfigField?
  
  private var verificationConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.verification
  }
  
  private var verificationCodeConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.verificationCode
  }
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    showVerificationMethod: Bool? = true,
    verificationMethodHeader: ConfigHeader? = nil,
    verificationCodeHeader: ConfigHeader? = nil,
    sendVerificationCodeTo: ConfigField? = nil,
    verificationField: ConfigField? = nil
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.showVerificationMethod = showVerificationMethod
    self.verificationMethodHeader = verificationMethodHeader ?? verificationConfig?.header
    self.verificationCodeHeader = verificationCodeHeader ?? verificationCodeConfig?.header
    self.sendVerificationCodeTo = sendVerificationCodeTo
    self.verificationField = verificationField
  }
}
