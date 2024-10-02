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
import CoalAccount

public class CoalNavigator: CoalNavigatorProtocol {
  
  public static let shared = CoalNavigator()
  
  public var window: UIWindow?
  private var tabManager: CoalTabProtocol?
  private var rootViewManager: CoalRootViewProtocol?
  
  private var config: CoalConfig { CoalConfig.shared }
  private var configLogoName: String?
  
  public func setTabBarController(_ tabBarController: CoalTabBarController) {
    self.tabManager = CoalTabManager(tabBarController: tabBarController)
    addDefaultTabs()
  }
  
  public func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
    guard let window = window else { fatalError("Window is not set") }
    self.rootViewManager = CoalRootView(window: window)
    rootViewManager?.setRootViewController(viewController, animated: animated)
    
    if let tabBarController = viewController as? CoalTabBarController {
      setTabBarController(tabBarController)
    }
  }
  
  public func addDefaultTabs() {
    let tabItems: [any View] = [
      HomeView(navigator: self, section: config.homeSection),
      AccountView(navigator: self)
    ]
    tabManager?.addTabs(tabItems)
  }
  
  public func showSplashScreen(backgroundColor: UIColor = .white, configLogoName: String? = nil, completion: (() -> Void)? = nil) {
    self.configLogoName = configLogoName ?? UIImage.coalLogo?.imageName
    let logoImage = UIImage(named: configLogoName ?? self.configLogoName ?? UIImage.coalLogo?.imageName ?? "")
    let splashscreenVC = SplashscreenFactory.createSplashscreen(backgroundColor: backgroundColor, clientLogoName: logoImage)
    
    setRootViewController(splashscreenVC, animated: false)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.showInitialPage(isLoggedIn: false, backgroundColor: backgroundColor)
      completion?()
    }
  }
  
  public func showInitialPage(isLoggedIn: Bool, backgroundColor: UIColor) {
    isLoggedIn ? showHomePage() : showLoginPage(backgroundColor: backgroundColor)
  }
  
  public func showLoginPage(backgroundColor: UIColor = .white, clientLogoName: String? = nil) {
    let loginView = LoginView(
      navigator: self,
      config: ConfigModel.currentConfig,
      clientLogoName: clientLogoName ?? configLogoName,
      backgroundColor: Color(backgroundColor)
    )
    rootViewManager?.setSwiftUIView(loginView, backgroundColor: backgroundColor)
  }
  
  public func showRegisterPage(backgroundColor: UIColor = .white) {
    let registerView = RegisterView(
      navigator: self,
      config: ConfigModel.currentConfig,
      backgroundColor: Color(backgroundColor)
    )
    rootViewManager?.setSwiftUIView(registerView, backgroundColor: backgroundColor)
  }
  
  public func showHomePage() {
    let tabBarController = CoalTabBarController()
    setRootViewController(tabBarController)
  }
  
  public func showAccountPage() {
    tabManager?.navigateToTab(at: 1)
  }
}
