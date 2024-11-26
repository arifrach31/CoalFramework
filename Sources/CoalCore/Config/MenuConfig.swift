//
//  MenuConfig.swift
//
//
//  Created by ArifRachman on 05/10/24.
//

import Foundation
import SwiftUI

public protocol MenuConfigProvider {
  func getConfig() -> MenuConfig
}

public class MenuConfig {
  public var isTabBarVisible: Bool?
  public var addTabItems: [MenuTabItem]?
  public var backgroundTabColor: UIColor?
  public var normalTabColor: UIColor?
  public var activeTabColor: UIColor?
  public var resetDefaultTab: Bool?
  
  public init(
    resetDefaultTab: Bool? = false,
    isTabBarVisible: Bool? = false,
    addTabItems: [MenuTabItem]? = nil,
    backgroundTabColor: UIColor? = .white,
    normalTabColor: UIColor? = .gray,
    activeTabColor: UIColor? = .blue
  ) {
    self.isTabBarVisible = isTabBarVisible
    self.addTabItems = addTabItems
    self.backgroundTabColor = backgroundTabColor
    self.normalTabColor = normalTabColor
    self.activeTabColor = activeTabColor
    self.resetDefaultTab = resetDefaultTab
  }
}
