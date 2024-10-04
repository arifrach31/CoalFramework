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
  let homeProvider = HomeProvider()
  
  func initCoalConfig() -> CoalConfig {
    let homeConfig = homeProvider.getConfig()
    return CoalConfig(homeConfig: homeConfig)
  }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    coalFramework.configure(
      windowScene: windowScene,
      logo: "garuda",
      frameworkConfig: initCoalConfig()
    )
  }
}
