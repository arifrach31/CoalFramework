//
//  SceneDelegate.swift
//  CoalClient
//
//  Created by ArifRachman on 14/09/24.
//

import UIKit
import CoalModel
import CoalFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, CoalHomeModelProtocol {
  var carouselItems: [CoalModel.CarouselModel] = [
    CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/camera__bo5k5tfk6cmu_large_2x.jpg"),
    CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/pro_lens2__e9qgfxdvjt26_large_2x.jpg"),
    CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/5x-zoom/pro-zoom_endframe__bpmc72f8qwgi_large_2x.jpg"),
    CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/camera__bo5k5tfk6cmu_large_2x.jpg"),
    CarouselModel(image: "garuda")
  ]
  
  var window: UIWindow?
  private let coalConfig = CoalConfig.shared
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    
    coalConfig.configure(
      window: window,
      logo: "garuda",
      homeSection: [
        .carousel(items: carouselItems),
        .productList,
        .category
      ])
  }
}
