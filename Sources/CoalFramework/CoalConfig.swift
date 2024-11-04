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
  var registerProvider: RegisterConfigProvider? { get }
  var verificationProvider: VerificationConfigProvider? { get }
  var menuProvider: MenuConfigProvider? { get }
  var homeProvider: HomeConfigProvider? { get }
  var networkProvider: NetworkConfigProvider? { get }
  var forgotProvider: ForgotConfigProvider? { get }
  var changePasswordProvider: ChangePasswordConfigProvider? { get }
  
  func getConfig() -> CoalConfig?
}

public struct CoalConfig {
  public static let shared = CoalConfig()
  
  public let splashConfig: SplashConfig?
  public let loginConfig: LoginConfig?
  public let registerConfig: RegisterConfig?
  public let verificationConfig: VerificationConfig?
  public let menuConfig: MenuConfig?
  public let homeConfig: HomeConfig?
  public let networkConfig: NetworkConfig?
  public let forgotConfig: ForgotConfig?
  public let changePasswordConfig: ChangePasswordConfig?
  
  public init(splashConfig: SplashConfig? = nil,
              loginConfig: LoginConfig? = nil,
              registerConfig: RegisterConfig? = nil,
              verificationConfig: VerificationConfig? = nil,
              menuConfig: MenuConfig? = nil,
              homeConfig: HomeConfig? = nil,
              networkConfig: NetworkConfig? = nil,
              forgotConfig: ForgotConfig? = nil,
              changePasswordConfig: ChangePasswordConfig? = nil) {
    self.splashConfig = splashConfig
    self.loginConfig = loginConfig
    self.registerConfig = registerConfig
    self.verificationConfig = verificationConfig
    self.menuConfig = menuConfig
    self.homeConfig = homeConfig
    self.networkConfig = networkConfig
    self.forgotConfig = forgotConfig
    self.changePasswordConfig = changePasswordConfig
  }
}
