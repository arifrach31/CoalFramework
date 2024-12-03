//
//  SceneDelegate.swift
//  CoalClient
//
//  Created by ArifRachman on 14/09/24.
//

import UIKit
import CoalFramework
import CoalCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CoalConfigDelegate {
  let coalFramework = CoalFramework.shared
  let appProvider = AppProvider()
  
  func initConfig() -> CoalConfig? {
    return appProvider.getConfig()
  }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    coalFramework.configure(
      windowScene: windowScene,
      frameworkConfig: initConfig()
    )
  }
}
