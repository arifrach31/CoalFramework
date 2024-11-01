//
//  SplashProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 04/10/24.
//

import CoalCore

class SplashProvider: SplashConfigProvider {
  func getConfig() -> SplashConfig {
    return SplashConfig(backgroundImageName: "background", backgroundColor: "#00a1dd", logoImage: "garuda")
  }
}
