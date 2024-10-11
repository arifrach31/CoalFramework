//
//  SceneDelegate.swift
//  CoalClient
//
//  Created by ArifRachman on 14/09/24.
//

import UIKit
import CoalFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CoalConfigDelegate {
  let coalFramework = CoalFramework.shared
  let appProvider = AppProvider(
    splashProvider: SplashProvider(),
    menuProvider: MenuProvider(),
    homeProvider: HomeProvider())
  
  func initCoalConfig() -> CoalConfig? {
    return appProvider.getConfig()
  }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    coalFramework.configure(
      windowScene: windowScene,
      frameworkConfig: initCoalConfig()
    )
  }
}
