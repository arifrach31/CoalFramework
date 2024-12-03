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

public class SplashConfig: BaseConfig {
  public var logoImage: String?
  public var delay: TimeInterval
  
  public init(
    backgroundImage: String? = nil,
    backgroundColor: String? = nil,
    logoImage: String? = nil,
    delay: TimeInterval = 2.0
  ) {
      self.logoImage = logoImage
      self.delay = delay
      super.init(backgroundImage: backgroundImage, backgroundColor: backgroundColor)
    }
}
