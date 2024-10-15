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
  var loginProvider: LoginConfigProvider? { get }
  var menuProvider: MenuConfigProvider? { get }
  var homeProvider: HomeConfigProvider? { get }
  
  func getConfig() -> CoalConfig?
}

public struct CoalConfig {
  public static let shared = CoalConfig()
  
  public let splashConfig: SplashConfig?
  public let loginConfig: LoginConfig?
  public let menuConfig: MenuConfig?
  public let registerConfig: RegisterConfig?
  public let homeConfig: HomeConfig?
  
  public init(splashConfig: SplashConfig? = nil,
              loginConfig: LoginConfig? = nil,
              menuConfig: MenuConfig? = nil,
              homeConfig: HomeConfig? = nil,
              registerConfig: RegisterConfig? = nil) {
    self.splashConfig = splashConfig
    self.loginConfig = loginConfig
    self.menuConfig = menuConfig
    self.registerConfig = registerConfig
    self.homeConfig = homeConfig
  }
}
