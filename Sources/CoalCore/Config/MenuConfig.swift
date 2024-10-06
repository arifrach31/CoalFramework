//
//  MenuConfig.swift
//
//
//  Created by ArifRachman on 05/10/24.
//

import Foundation

public protocol MenuConfigProvider {
  func getConfig() -> MenuConfig
}

public class MenuConfig {
  public var isShowTabBar: Bool?
  
  public init(isShowTabBar: Bool? = false) {
    self.isShowTabBar = isShowTabBar
  }
}
