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
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = ConfigDefault.forgotFields
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.header = header
    self.fields = fields
  }
}
