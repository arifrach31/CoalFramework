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
    tabManager = CoalTabManager(coalEnvironment: coalEnvironment)
  }
  
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
        actionScreen: .swiftui(homeView)
      ),
      MenuTabItem(
        title: accountView.coalTabInfo().title,
        icon: accountView.coalTabInfo().icon,
        actionScreen: .swiftui(accountView)
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
      let splashView = SplashView(navigator: self,
                                  config: config?.splashConfig)
      rootViewManager?.setSwiftUIView(splashView)
      return
    case .login:
      view =  LoginView(
        navigator: self,
        config: config?.loginConfig
      )
    case .register:
      view = RegisterView(navigator: self,
                          config: config?.registerConfig)
    case .home:
      view = setupTabs()
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
      view = VerificationMethodView(navigator: self,
                                    config: config?.verificationConfig)
    case .verificationCode(let journey, let methodField):
      view = VerificationCodeView(
        navigator: self,
        config: config?.verificationConfig,
        methodField: methodField,
        verificationType: journey
      )
    case .forgot:
      view = ForgotView(
        navigator: self,
        config: config?.forgotConfig)
    case .changePassword:
      view = ChangePasswordView(
        navigator: self,
        config: config?.changePasswordConfig)
    case .webview(let model):
      view = WebView(
        navigator: self,
        config: model)
    }
    
    rootViewManager?.pushViewController(view)
  }
}
