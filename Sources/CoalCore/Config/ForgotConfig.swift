//
//  ForgotConfig.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import Foundation

public protocol ForgotConfigProvider {
  func getConfig() -> ForgotConfig
}

public class ForgotConfig: BaseConfig {
  public var header: ConfigHeader? = nil
  public var fields: [ConfigField]? = ConfigDefault.forgotFields
  public var actionScreen: CoalScreen = .changePassword
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = ConfigDefault.forgotFields,
    actionScreen: CoalScreen = .changePassword
  ) {
    self.header = header
    self.fields = fields
    self.actionScreen = actionScreen
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
  }
}
