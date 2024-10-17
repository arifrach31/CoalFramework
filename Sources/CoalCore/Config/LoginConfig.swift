//
//  LoginConfig.swift
//  
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

public protocol LoginConfigProvider {
  func getConfig() -> LoginConfig
  func getLoginFields(for type: LoginType) -> [ConfigField]
}

public class LoginConfig: BaseConfig {
  public var loginHeader: ConfigHeader?
  public var loginFields: [ConfigField]?
  public var additionalButtonConfig: AdditionalButtonConfig?
  public var verificationMethods: [ConfigField]?
  public var verificationMethodHeader: ConfigHeader?
  public var showRegister: Bool?
  public var showForgotPassword: Bool?
  public var showVerificationMethod: Bool?
  public var showHome: Bool?
  
  private var loginConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.login
  }
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    loginHeader: ConfigHeader? = nil,
    loginFields: [ConfigField]? = nil,
    additionalButtonConfig: AdditionalButtonConfig? = nil,
    verificationMethods: [ConfigField]? = nil,
    verificationMethodHeader: ConfigHeader? = nil,
    showRegister: Bool = true,
    showForgotPassword: Bool = true,
    showVerificationMethod: Bool = true,
    showHome: Bool = true
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.loginHeader = loginHeader ?? loginConfig?.header
    self.loginFields = loginFields ?? loginConfig?.fields
    self.additionalButtonConfig = additionalButtonConfig
    self.verificationMethods = verificationMethods
    self.verificationMethodHeader = verificationMethodHeader
    self.showRegister = showRegister
    self.showForgotPassword = showForgotPassword
    self.showVerificationMethod = showVerificationMethod
    self.showHome = showHome
  }
}
