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
  let menuProvider: MenuConfigProvider?
  let homeProvider: HomeConfigProvider?
  
  init(splashProvider: SplashConfigProvider? = nil,
       menuProvider: MenuConfigProvider? = nil,
       homeProvider: HomeConfigProvider? = nil) {
    self.splashProvider = splashProvider
    self.menuProvider = menuProvider
    self.homeProvider = homeProvider
  }
  
  func getConfig() -> CoalConfig? {
    return CoalConfig(
      splashConfig: splashProvider?.getConfig(),
      menuConfig: menuProvider?.getConfig(),
      homeConfig: homeProvider?.getConfig()
    )
  }
}
