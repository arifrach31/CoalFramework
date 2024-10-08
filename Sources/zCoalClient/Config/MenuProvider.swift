//
//  MenuProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalCore

class MenuProvider: MenuConfigProvider {
  let isShowTabBar: Bool? = true
  
  func getConfig() -> MenuConfig {
    return MenuConfig(isShowTabBar: isShowTabBar)
  }
}
