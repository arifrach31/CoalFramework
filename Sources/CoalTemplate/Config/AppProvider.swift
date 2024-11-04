//
//  AppProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalFramework
import CoalCore

class AppProvider: CoalAppProvider {
  let splashProvider: SplashConfigProvider?
  let loginProvider: LoginConfigProvider?
  let registerProvider: RegisterConfigProvider?
  var verificationProvider: VerificationConfigProvider?
  let menuProvider: MenuConfigProvider?
  let homeProvider: HomeConfigProvider?
  let networkProvider: NetworkConfigProvider?
  var forgotProvider: ForgotConfigProvider?
  var changePasswordProvider: ChangePasswordConfigProvider?
  
  init(splashProvider: SplashConfigProvider? = nil,
       loginProvider: LoginConfigProvider? = nil,
       registerProvider: RegisterConfigProvider? = nil,
       verificationProvider: VerificationConfigProvider? = nil,
       menuProvider: MenuConfigProvider? = nil,
       homeProvider: HomeConfigProvider? = nil,
       networkProvider: NetworkConfigProvider? = nil,
       forgotProvider: ForgotConfigProvider? = nil,
       changePasswordProvider: ChangePasswordConfigProvider? = nil) {
    self.splashProvider = splashProvider
    self.loginProvider = loginProvider
    self.registerProvider = registerProvider
    self.verificationProvider = verificationProvider
    self.menuProvider = menuProvider
    self.homeProvider = homeProvider
    self.networkProvider = networkProvider
    self.forgotProvider = forgotProvider
    self.changePasswordProvider = changePasswordProvider
  }
  
  func getConfig() -> CoalConfig? {
    return CoalConfig(
      splashConfig: splashProvider?.getConfig(),
      loginConfig: loginProvider?.getConfig(),
      registerConfig: registerProvider?.getConfig(),
      verificationConfig: verificationProvider?.getConfig(),
      menuConfig: menuProvider?.getConfig(),
      homeConfig: homeProvider?.getConfig(),
      networkConfig: networkProvider?.getConfig(),
      forgotConfig: forgotProvider?.getConfig(),
      changePasswordConfig: changePasswordProvider?.getConfig()
    )
  }
}
