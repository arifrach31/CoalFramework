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
import CoalVerification

public class CoalNavigator: CoalNavigatorProtocol {
  public static let shared = CoalNavigator()
  
  public var windowScene: UIWindowScene? {
    didSet {
      if oldValue == nil, let windowScene = windowScene {
        rootViewManager = CoalRootView(windowScene: windowScene)
      }
    }
  }
  
  private var tabManager: CoalTabProtocol?
  private var rootViewManager: CoalRootViewProtocol?
  private var config: CoalConfig?
  
  public func configure(_ config: CoalConfig?) {
    self.config = config
  }
  
  private func setupTabBarController(_ tabBarController: CoalTabBarController) {
    rootViewManager?.setRootViewController(tabBarController)

    tabManager = CoalTabManager(tabBarController: tabBarController)
    tabManager?.setShowTabBar(isShowTab: config?.menuConfig?.isShowTabBar ?? false)
    addDefaultTabs()
    
    if let additionalTabs = config?.menuConfig?.addTabItems {
      tabManager?.addNewTab(additionalTabs)
    }
  }
  
  private func addDefaultTabs() {
    let homeView = HomeView(navigator: self, config: config?.homeConfig)
    let accountView = AccountView(navigator: self)
    
    let tabItems: [MenuTabItem] = [
      MenuTabItem(
        title: homeView.coalTabInfo().title,
        icon: homeView.coalTabInfo().icon,
        screen: .swiftUIView(AnyView(homeView))
      ),
      MenuTabItem(
        title: accountView.coalTabInfo().title,
        icon: accountView.coalTabInfo().icon,
        screen: .swiftUIView(AnyView(accountView))
      )
    ]
    
    tabManager?.addTabs(tabItems)
  }
  
  public func pushToViewController<Content: View>(_ swiftUIView: Content) {
    rootViewManager?.pushViewController(swiftUIView)
  }
  
  public func popToPreviousView() {
    rootViewManager?.popViewController(animated: false)
  }
  
  public func showInitialPage(isLoggedIn: Bool) {
    isLoggedIn ? self.goTo(.home) : self.goTo(.login)
  }
  
  public func goTo(_ screen: CoalScreen) {
    let view: AnyView
    
    switch screen {
    case .splash:
      let splashView = SplashView(navigator: self,
                                  config: config?.splashConfig)
      rootViewManager?.setSwiftUIView(splashView)
      return
    case .login:
      let loginView = LoginView(navigator: self,
                                config: config?.loginConfig)
      view = AnyView(loginView)
    case .register:
      let registerView = RegisterView(navigator: self,
                                      config: config?.registerConfig)
      view = AnyView(registerView)
    case .home:
      setupTabBarController(CoalTabBarController())
      return
    case .account:
      tabManager?.navigateToTab(at: 1)
      return
    case .verificationMethod:
      guard let showMethod = config?.verificationConfig?.showVerificationMethod, showMethod else {
        goTo(.verificationCode(methodField: nil))
        return
      }
      let verifView = VerificationMethodView(navigator: self,
                                             config: config?.verificationConfig)
      view = AnyView(verifView)
    case .verificationCode(let methodField):
      let verifView = VerificationCodeView(navigator: self,
                                           config: config?.verificationConfig,
                                           methodField: methodField)
      view = AnyView(verifView)
    }
    
    rootViewManager?.pushViewController(view)
  }
}
