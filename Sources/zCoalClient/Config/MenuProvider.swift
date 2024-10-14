//
//  MenuProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalCore

class MenuProvider: MenuConfigProvider {
  let isShowTabBar: Bool? = true
  let customTabItems = [
    MenuTabItem(
      title: "About",
      icon: "profile",
      screen: .uiKitViewController(AboutViewController()) // client class vc
    )
  ]
  
  func getConfig() -> MenuConfig {
    return MenuConfig(isShowTabBar: isShowTabBar, addTabItems: customTabItems)
  }
}
