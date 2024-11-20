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
import CoalForgot
import CoalChangePassword
import CoalWebView

public class CoalNavigator: CoalNavigatorProtocol, ObservableObject {
  public static let shared = CoalNavigator()
  
  private var rootViewManager: CoalRootViewProtocol?
  private var config: CoalConfig?
  private var coalEnvironment = CoalEnvironment()
  
  @Published private var tabManager: CoalTabManager
  
  public init() {
    tabManager = CoalTabManager()
  }
  
  public func configure(_ config: CoalConfig?, windowScene: UIWindowScene?) {
    self.config = config
    if let windowScene = windowScene, let config = self.config {
      rootViewManager = CoalRootView(
        windowScene: windowScene,
        coalEnvironment: coalEnvironment,
        coalConfig: config
      )
    }
  }
  
  public func setupTabs() -> some View {
    let homeView = HomeView(navigator: self)
    let accountView = AccountView(navigator: self)
    
    if config?.menuConfig?.resetDefaultTab != true {
      let tabItems: [MenuTabItem] = [
        MenuTabItem(
          title: homeView.coalTabInfo().title,
          icon: homeView.coalTabInfo().icon,
          viewScreen: .swiftui(homeView)
        ),
        MenuTabItem(
          title: accountView.coalTabInfo().title,
          icon: accountView.coalTabInfo().icon,
          viewScreen: .swiftui(accountView)
        )
      ]
      tabManager.addTab(tabItems)
    }
    
    if let customTabs = config?.menuConfig?.addTabItems {
      tabManager.addTab(customTabs)
    }
    
    return CoalTabBarView(
      tabManager: tabManager,
      coalEnvironment: coalEnvironment,
      coalConfig: config ?? CoalConfig()
    )
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
  
  public func navigate(_ destination: ViewScreenType) {
    switch destination {
    case .swiftui(let swiftUIView):
      rootViewManager?.pushViewController(swiftUIView)
    case .uikit(let viewController):
      rootViewManager?.pushViewController(viewController)
    }
  }
  
  public func goTo(_ destination: CoalScreenType) {
    let view: any View
    
    switch destination {
    case .splash:
      let splashView = SplashView(navigator: self)
      rootViewManager?.setSwiftUIView(splashView)
      return
    case .login:
      view =  LoginView(navigator: self)
    case .register:
      view = RegisterView(navigator: self)
    case .home:
      view = setupTabs()
    case .account:
      tabManager.navigateToTab(at: 1)
      return
    case .verificationMethod:
      guard let showMethod = config?.verificationConfig?.showVerificationMethod, showMethod else {
        goTo(
          .verificationCode(
            type: .login,
            methodField: nil
          )
        )
        return
      }
      view = VerificationMethodView(navigator: self)
    case .verificationCode(let type, let methodField):
      view = VerificationCodeView(
        navigator: self,
        methodField: methodField,
        verificationType: type
      )
    case .forgot:
      view = ForgotView(navigator: self)
    case .changePassword:
      view = ChangePasswordView(navigator: self)
    case .webview(let model):
      view = WebView(
        navigator: self,
        config: model)
    }
    
    rootViewManager?.pushViewController(view)
  }
}
