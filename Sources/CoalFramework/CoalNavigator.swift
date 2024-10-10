//
//  Navigator.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import SwiftUI
import CoalCore
import CoalSplashScreen
import CoalLogin
import CoalRegister
import CoalHome
import CoalAccount

public class CoalNavigator: CoalNavigatorProtocol {
  
  public static let shared = CoalNavigator()
  
  public var windowScene: UIWindowScene?
  private var tabManager: CoalTabProtocol?
  private var rootViewManager: CoalRootViewProtocol?
  private var config: CoalConfig?
  
  public func setViewConfig(_ config: CoalConfig?) {
    self.config = config
  }
  
  private func initRootViewManager() {
    guard rootViewManager == nil else { return }
    
    guard let windowScene = windowScene else { fatalError("windowScene is not set") }
    self.rootViewManager = CoalRootView(windowScene: windowScene)
  }
  
  public func setTabBarController(_ tabBarController: CoalTabBarController) {
    self.tabManager = CoalTabManager(tabBarController: tabBarController)
    if let isShowTabBar = config?.menuConfig?.isShowTabBar {
      tabManager?.setShowTabBar(isShowTab: isShowTabBar)
    }
    addDefaultTabs()
  }
  
  public func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
    initRootViewManager()
    rootViewManager?.setRootViewController(viewController, animated: animated)
    
    if let tabBarController = viewController as? CoalTabBarController {
      setTabBarController(tabBarController)
    }
  }
  
  public func addDefaultTabs() {
    let tabItems: [any View] = [
      HomeView(navigator: self, config: config?.homeConfig),
      AccountView(navigator: self)
    ]
    tabManager?.addTabs(tabItems)
  }
  
  public func showSplashScreen() {
    initRootViewManager()
    
    let splashView = SplashView(config: config?.splashConfig)
    rootViewManager?.setSwiftUIView(splashView)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
      self.showInitialPage(isLoggedIn: false)
    }
  }
  
  public func showInitialPage(isLoggedIn: Bool) {
    isLoggedIn ? showHomePage() : showLoginPage()
  }
  
  public func showLoginPage() {
    let loginView = LoginView(
      navigator: self,
      config: ConfigModel.currentConfig,
      backgroundColor: Color(.white)
    )
    rootViewManager?.setSwiftUIView(loginView)
  }
  
  public func showRegisterPage(backgroundColor: UIColor = .white) {
    let registerView = RegisterView(
      navigator: self,
      config: ConfigModel.currentConfig,
      backgroundColor: Color(backgroundColor)
    )
    rootViewManager?.setSwiftUIView(registerView)
  }
  
  public func showHomePage() {
    let tabBarController = CoalTabBarController()
    setRootViewController(tabBarController)
  }
  
  public func showAccountPage() {
    tabManager?.navigateToTab(at: 1)
  }
}
