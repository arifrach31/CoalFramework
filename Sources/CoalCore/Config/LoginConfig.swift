//
//  LoginConfig.swift
//  
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

public protocol LoginConfigProvider {
  func getConfig() -> LoginConfig
}

public class LoginConfig: BaseConfig {
  public var header: ConfigHeader? = nil
  public var fields: [ConfigField]? = nil
  public var additionalButtonConfig: AdditionalButtonConfig?
  public var loginButtonAction: ViewScreenType?
  
  private var loginConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.login
  }
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = nil,
    additionalButtonConfig: AdditionalButtonConfig? = nil,
    loginButtonAction: ViewScreenType? = nil
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.header = header ?? loginConfig?.header
    self.fields = fields ?? loginConfig?.fields
    self.additionalButtonConfig = additionalButtonConfig
    self.loginButtonAction = loginButtonAction
  }
}
