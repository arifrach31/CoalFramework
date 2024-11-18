//
//  MenuProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalCore

class MenuProvider: MenuConfigProvider {
  func getConfig() -> MenuConfig {
    return MenuConfig(
      resetDefaultTab: false,
      isTabBarVisible: true,
      addTabItems: [
        MenuTabItem(
          title: "About",
          icon: "folder.fill",
          viewScreen: .swiftui(ClientView())
        )
      ],
      normalTabColor: .black,
      activeTabColor: .red
    )
  }
}
