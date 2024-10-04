//
//  CoalConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import CoalCore

public protocol CoalConfigDelegate {
  func initCoalConfig() -> CoalConfig
}

public struct CoalConfig {
  public static let shared = CoalConfig()
  
  public let homeConfig: HomeConfig?
  public let loginConfig: LoginConfig?
  public let registerConfig: RegisterConfig?
  
  public init(homeConfig: HomeConfig? = nil, loginConfig: LoginConfig? = nil, registerConfig: RegisterConfig? = nil) {
    self.homeConfig = homeConfig
    self.loginConfig = loginConfig
    self.registerConfig = registerConfig
  }
}
