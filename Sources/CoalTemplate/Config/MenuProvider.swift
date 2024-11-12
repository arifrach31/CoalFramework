//
//  MenuProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import SwiftUI
import CoalCore

class MenuProvider: MenuConfigProvider {
  func getConfig() -> MenuConfig {
    return MenuConfig(
      isShowTabBar: true,
      addTabItems: [
        MenuTabItem(
          title: "About",
          icon: "folder.fill",
          actionScreen: .swiftUIView(AnyView(ClientView()))
        )
      ]
    )
  }
}
