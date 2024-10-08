//
//  AppProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalFramework
import CoalCore

class AppProvider {
  let homeProvider: HomeConfigProvider
  let splashProvider: SplashConfigProvider
  let menuProvider: MenuConfigProvider
  
  init(homeProvider: HomeConfigProvider = HomeProvider(),
       splashProvider: SplashConfigProvider = SplashProvider(),
       menuProvider: MenuConfigProvider = MenuProvider()) {
    self.homeProvider = homeProvider
    self.splashProvider = splashProvider
    self.menuProvider = menuProvider
  }
  
  func getConfig() -> CoalConfig {
    return CoalConfig(
      splashConfig: splashProvider.getConfig(),
      homeConfig: homeProvider.getConfig(),
      menuConfig: menuProvider.getConfig()
    )
  }
}
