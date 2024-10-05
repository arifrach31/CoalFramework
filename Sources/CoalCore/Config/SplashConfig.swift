//
//  SplashConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

public protocol SplashConfigProvider {
  func getConfig() -> SplashConfig
}

public class SplashConfig {
  public var backgroundImage: String?
  public var backgroundColor: String?
  public var logoImage: String?
  
  public init(backgroundImage: String? = nil, backgroundColor: String? = nil, logoImage: String? = nil) {
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
    self.logoImage = logoImage
  }
}
