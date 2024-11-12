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
  
  @Published private var tabManager = CoalTabManager()
  
  public var windowScene: UIWindowScene? {
    didSet {
      if oldValue == nil, let windowScene = windowScene {
        rootViewManager = CoalRootView(windowScene: windowScene, coalEnvironment: coalEnvironment)
      }
    }
  }
  
  public func configure(_ config: CoalConfig?) {
    self.config = config
  }
  
  public func setupTabs() -> some View {
    let homeView = HomeView(navigator: self, config: config?.homeConfig)
    let accountView = AccountView(navigator: self)
    
    let tabItems: [MenuTabItem] = [
      MenuTabItem(
        title: homeView.coalTabInfo().title,
        icon: homeView.coalTabInfo().icon,
        actionScreen: AnyView(homeView)
      ),
      MenuTabItem(
        title: accountView.coalTabInfo().title,
        icon: accountView.coalTabInfo().icon,
        actionScreen: AnyView(accountView)
      )
    ]
    tabManager.addTab(tabItems)
    
    if let customTabs = config?.menuConfig?.addTabItems {
      tabManager.addTab(customTabs)
    }
    
    return CoalTabBarView(tabManager: tabManager)
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
      let loginView = LoginView(
        navigator: self,
        config: config?.loginConfig
      )
      view = AnyView(loginView)
    case .register:
      let registerView = RegisterView(navigator: self,
                                      config: config?.registerConfig)
      view = AnyView(registerView)
    case .home:
      view = AnyView(setupTabs())
    case .account:
      tabManager.navigateToTab(at: 1)
      return
    case .verificationMethod:
      guard let showMethod = config?.verificationConfig?.showVerificationMethod, showMethod else {
        goTo(
          .verificationCode(
            journey: .login,
            methodField: nil
          )
        )
        return
      }
      let verifView = VerificationMethodView(navigator: self,
                                             config: config?.verificationConfig)
      view = AnyView(verifView)
    case .verificationCode(let journey, let methodField):
      let verifView = VerificationCodeView(
        navigator: self,
        config: config?.verificationConfig,
        methodField: methodField,
        journey: journey
      )
      view = AnyView(verifView)
    case .forgot:
      let forgotView = ForgotView(
        navigator: self,
        config: config?.forgotConfig)
      view = AnyView(forgotView)
    case .changePassword:
      let changePasswordView = ChangePasswordView(
        navigator: self,
        config: config?.changePasswordConfig)
      view = AnyView(changePasswordView)
    case .webview(let model):
      let webView = WebView(
        navigator: self,
        config: model)
      view = AnyView(webView)
    }
    
    rootViewManager?.pushViewController(view)
  }
}
