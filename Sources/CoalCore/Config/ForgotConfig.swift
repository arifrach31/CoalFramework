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
  public var coalScreen: CoalScreenType = .changePassword
  
  public init(
    backgroundImage: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = ConfigDefault.forgotFields,
    coalScreen: CoalScreenType = .changePassword
  ) {
    self.header = header
    self.fields = fields
    self.coalScreen = coalScreen
    super.init(backgroundImage: backgroundImage, backgroundColor: backgroundColor)
  }
}
