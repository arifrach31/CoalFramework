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

public protocol CoalAppProvider {
  var homeProvider: HomeConfigProvider { get }
  var splashProvider: SplashConfigProvider { get }
  
  func getConfig() -> CoalConfig
}

public struct CoalConfig {
  public static let shared = CoalConfig()
  
  public let splashConfig: SplashConfig?
  public let homeConfig: HomeConfig?
  public let loginConfig: LoginConfig?
  public let registerConfig: RegisterConfig?
  
  public init(splashConfig: SplashConfig? = nil, homeConfig: HomeConfig? = nil, loginConfig: LoginConfig? = nil, registerConfig: RegisterConfig? = nil) {
    self.homeConfig = homeConfig
    self.loginConfig = loginConfig
    self.registerConfig = registerConfig
    self.splashConfig = splashConfig
  }
}
