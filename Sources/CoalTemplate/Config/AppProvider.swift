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
  var verificationProvider: VerificationConfigProvider?
  let menuProvider: MenuConfigProvider?
  let homeProvider: HomeConfigProvider?
  let networkProvider: NetworkConfigProvider?
  
  init(splashProvider: SplashConfigProvider? = nil,
       loginProvider: LoginConfigProvider? = nil,
       verificationProvider: VerificationConfigProvider? = nil,
       menuProvider: MenuConfigProvider? = nil,
       homeProvider: HomeConfigProvider? = nil,
       networkProvider: NetworkConfigProvider? = nil) {
    self.splashProvider = splashProvider
    self.loginProvider = loginProvider
    self.verificationProvider = verificationProvider
    self.menuProvider = menuProvider
    self.homeProvider = homeProvider
    self.networkProvider = networkProvider
  }
  
  func getConfig() -> CoalConfig? {
    return CoalConfig(
      splashConfig: splashProvider?.getConfig(),
      loginConfig: loginProvider?.getConfig(),
      verificationConfig: verificationProvider?.getConfig(),
      menuConfig: menuProvider?.getConfig(),
      homeConfig: homeProvider?.getConfig(),
      networkConfig: networkProvider?.getConfig()
    )
  }
}
