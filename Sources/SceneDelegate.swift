//
//  SceneDelegate.swift
//  CoalClient
//
//  Created by ArifRachman on 14/09/24.
//

import UIKit
import CoalFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private let coalConfig = CoalConfig.shared
  private let homeProvider = HomeProvider()
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    
    coalConfig.configure(
      window: window,
      logo: "garuda",
      homeSection: [
        .carousel(items: homeProvider.getCarouselItems()),
        .productList,
        .category
      ])
  }
}
