//
//  ChangePasswordConfig.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import Foundation

public protocol ChangePasswordConfigProvider {
  func getConfig() -> ChangePasswordConfig
}

public class ChangePasswordConfig: BaseConfig {
  public var header: ConfigHeader? = nil
  public var fields: [ConfigField]? = ConfigDefault.changePasswordFields
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = ConfigDefault.changePasswordFields
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.header = header
    self.fields = fields
  }
}
