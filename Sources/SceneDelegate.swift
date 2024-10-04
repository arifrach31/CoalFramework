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
  var window: UIWindow?
  let coalFramework = CoalFramework.shared
  let homeProvider = HomeProvider()
  
  func initCoalConfig() -> CoalConfig {
    let homeConfig = HomeConfig(sections: [
      .carousel(items: homeProvider.getCarouselItems()),
      .category(items: homeProvider.getCategories()),
      .productList(items: homeProvider.getProductList())
    ])
    return CoalConfig(homeConfig: homeConfig)
  }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    
    coalFramework.configure(
      window: window,
      logo: "garuda",
      frameworkConfig: initCoalConfig()
    )
  }
}
