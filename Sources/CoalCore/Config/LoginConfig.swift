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
  public var forgotButtonConfig: ForgotButtonConfig?
  
  private var loginConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.login
  }
  
  public init(backgroundImageName: String? = nil,
              backgroundColor: String? = nil,
              loginHeader: ConfigHeader? = nil,
              loginFields: [ConfigField]? = nil,
              forgotButtonConfig: ForgotButtonConfig? = nil) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.loginHeader = loginHeader ?? loginConfig?.header
    self.loginFields = loginFields ?? loginConfig?.fields
    self.forgotButtonConfig = forgotButtonConfig
  }
}
