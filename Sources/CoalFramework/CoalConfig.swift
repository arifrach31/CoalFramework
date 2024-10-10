//
//  CoalConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import CoalCore

public protocol CoalConfigDelegate {
  func initCoalConfig() -> CoalConfig?
}

public protocol CoalAppProvider {
  var splashProvider: SplashConfigProvider? { get }
  var menuProvider: MenuConfigProvider? { get }
  var homeProvider: HomeConfigProvider? { get }
  
  func getConfig() -> CoalConfig?
}

public struct CoalConfig {
  public static let shared = CoalConfig()
  
  public let splashConfig: SplashConfig?
  public let menuConfig: MenuConfig?
  public let loginConfig: LoginConfig?
  public let registerConfig: RegisterConfig?
  public let homeConfig: HomeConfig?
  
  public init(splashConfig: SplashConfig? = nil,
              menuConfig: MenuConfig? = nil,
              homeConfig: HomeConfig? = nil,
              loginConfig: LoginConfig? = nil,
              registerConfig: RegisterConfig? = nil) {
    self.splashConfig = splashConfig
    self.menuConfig = menuConfig
    self.loginConfig = loginConfig
    self.registerConfig = registerConfig
    self.homeConfig = homeConfig
  }
}
