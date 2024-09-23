//
//  Navigator.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import SwiftUI
import CoalCore
import CoalModel
import CoalView
import CoalSplashScreen
import CoalLogin
import CoalRegister
import CoalHome

public class CoalNavigator: CoalNavigatorProtocol {
  public static let shared = CoalNavigator()
  
  public var window: UIWindow?
  private var tabBarController: CoalTabBarController?
  private var configLogoName: String?
  
  public func addDefaultTabs() {
    guard let tabBarController = tabBarController else {
      print("TabBarController is not initialized")
      return
    }
    
    let carouselItems = [
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/camera__bo5k5tfk6cmu_large_2x.jpg"),
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/camera/pro_lens2__e9qgfxdvjt26_large_2x.jpg"),
      CarouselModel(image: "https://www.apple.com/v/iphone-15-pro/c/images/overview/5x-zoom/pro-zoom_endframe__bpmc72f8qwgi_large_2x.jpg")
    ]
    
    let sections: [HomeSection] = [
      .category,
      .carousel(items: carouselItems),
      .productList
    ]
    
    let homeView = HomeView(navigator: self, sections: sections)
    let homeHostingController = UIHostingController(rootView: homeView)
    
    tabBarController.addTab(viewController: homeHostingController, atIndex: 0)
  }
  
  public func setRootViewController(viewController: UIViewController, animated: Bool = true) {
    guard let window = window else {
      fatalError("Window is not set")
    }
    
    if let tabBarController = viewController as? CoalTabBarController {
      self.tabBarController = tabBarController
      self.addDefaultTabs()
    }
    
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  public func setSwiftUIView<Content: View>(swiftUIView: Content, backgroundColor: UIColor? = nil) {
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    if let backgroundColor = backgroundColor {
      hostingController.view.backgroundColor = backgroundColor
    }
    
    setRootViewController(viewController: hostingController, animated: false)
  }
  
  public func showSplashScreen(backgroundColor: UIColor = .white, configLogoName: String? = nil, completion: (() -> Void)? = nil) {
    var logoImage: UIImage?
    
    if let logoName = configLogoName {
      logoImage = UIImage(named: logoName)
      self.configLogoName = logoName
    } else {
      logoImage = UIImage.coalLogo
      self.configLogoName = UIImage.coalLogo?.imageName
    }
    
    let splashscreenVC = SplashscreenFactory.createSplashscreen(backgroundColor: backgroundColor, clientLogoName: logoImage)
    setRootViewController(viewController: splashscreenVC, animated: false)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      let initialRootVC = self.window?.rootViewController
      if self.window?.rootViewController === initialRootVC {
        let isLoggedIn = false
        self.showInitialPage(isLoggedIn: isLoggedIn, backgroundColor: backgroundColor)
      }
      completion?()
    }
  }
  
  public func showInitialPage(isLoggedIn: Bool, backgroundColor: UIColor) {
    if isLoggedIn {
      showHomePage()
    } else {
      showLoginPage(backgroundColor: backgroundColor, clientLogoName: nil)
    }
  }
  
  public func showLoginPage(backgroundColor: UIColor = .white, clientLogoName: String? = nil) {
    let logoToUse = clientLogoName ?? self.configLogoName
    let loginView = LoginView(
      navigator: self,
      config: ConfigModel.currentConfig,
      clientLogoName: logoToUse,
      backgroundColor: Color(backgroundColor)
    )
    
    setSwiftUIView(swiftUIView: loginView, backgroundColor: backgroundColor)
  }
  
  public func showHomePage() {
    let tabBarController = CoalTabBarController()
    self.tabBarController = tabBarController
    setRootViewController(viewController: tabBarController, animated: true)
  }
  
  public func showRegisterPage(backgroundColor: UIColor = .white) {
    let registerView = RegisterView(
      navigator: self,
      config: ConfigModel.currentConfig,
      backgroundColor: Color(backgroundColor))
    setSwiftUIView(swiftUIView: registerView, backgroundColor: backgroundColor)
  }
}
