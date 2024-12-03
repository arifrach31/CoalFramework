//
//  AppProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 05/10/24.
//

import CoalFramework
import CoalCore

class AppProvider: CoalAppProvider {
  private let splashProvider = SplashProvider()
  private let loginProvider = LoginProvider()
  private let registerProvider = RegisterProvider()
  private let verificationProvider = VerificationProvider()
  private let menuProvider = MenuProvider()
  private let homeProvider = HomeProvider()
  private let networkProvider = NetworkProvider()
  private let forgotProvider = ForgotProvider()
  private let changePasswordProvider = ChangePasswordProvider()
  
  func getConfig() -> CoalConfig? {
    return CoalConfig(
      splashConfig: splashProvider.getConfig(),
      loginConfig: loginProvider.getConfig(),
      registerConfig: registerProvider.getConfig(),
      verificationConfig: verificationProvider.getConfig(),
      menuConfig: menuProvider.getConfig(),
      homeConfig: homeProvider.getConfig(),
      networkConfig: networkProvider.getConfig(),
      forgotConfig: forgotProvider.getConfig(),
      changePasswordConfig: changePasswordProvider.getConfig()
    )
  }
}
