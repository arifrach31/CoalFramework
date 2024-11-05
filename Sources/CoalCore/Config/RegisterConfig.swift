//
//  RegisterConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

public protocol RegisterConfigProvider {
  func getConfig() -> RegisterConfig
}

public class RegisterConfig: BaseConfig {
  public var header: ConfigHeader? = nil
  public var fields: [ConfigField]? = nil
  public var privacyPolicy: WebViewModel? = nil
  public var termCondition: WebViewModel? = nil
  
  private var registerConfig: ConfigPage? {
    ConfigModel.currentConfig?.pages?.register
  }
  
  public init(
    backgroundImageName: String? = nil,
    backgroundColor: String? = nil,
    header: ConfigHeader? = nil,
    fields: [ConfigField]? = nil,
    privacyPolicy: WebViewModel? = nil,
    termCondition: WebViewModel? = nil
  ) {
    super.init(backgroundImageName: backgroundImageName, backgroundColor: backgroundColor)
    self.header = header ?? registerConfig?.header
    self.fields = fields ?? registerConfig?.fields
    self.privacyPolicy = privacyPolicy
    self.termCondition = termCondition
  }
}
