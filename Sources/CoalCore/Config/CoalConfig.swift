//
//  CoalConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

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

public class CoalConfig: ObservableObject {
  public static let shared = CoalConfig()
  
  @Published public var splashConfig: SplashConfig?
  @Published public var loginConfig: LoginConfig?
  @Published public var registerConfig: RegisterConfig?
  @Published public var verificationConfig: VerificationConfig?
  @Published public var menuConfig: MenuConfig?
  @Published public var homeConfig: HomeConfig?
  @Published public var networkConfig: NetworkConfig?
  @Published public var forgotConfig: ForgotConfig?
  @Published public var changePasswordConfig: ChangePasswordConfig?
  
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
