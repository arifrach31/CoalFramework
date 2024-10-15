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
  let menuProvider: MenuConfigProvider?
  let homeProvider: HomeConfigProvider?
  
  init(splashProvider: SplashConfigProvider? = nil,
       loginProvider: LoginConfigProvider? = nil,
       menuProvider: MenuConfigProvider? = nil,
       homeProvider: HomeConfigProvider? = nil) {
    self.splashProvider = splashProvider
    self.loginProvider = loginProvider
    self.menuProvider = menuProvider
    self.homeProvider = homeProvider
  }
  
  func getConfig() -> CoalConfig? {
    return CoalConfig(
      splashConfig: splashProvider?.getConfig(),
      loginConfig: loginProvider?.getConfig(),
      menuConfig: menuProvider?.getConfig(),
      homeConfig: homeProvider?.getConfig()
    )
  }
}
