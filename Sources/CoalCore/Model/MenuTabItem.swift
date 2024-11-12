//
//  MenuTabItem.swift
//
//
//  Created by ArifRachman on 12/10/24.
//

import SwiftUI
import UIKit

public enum ScreenType {
  case swiftUIView(AnyView)
  case uiKitViewController(UIViewController)
}

public struct MenuTabItem {
  public var title: String?
  public var icon: String?
  public var actionScreen: ScreenType
  
  public init(title: String? = nil, icon: String? = nil, actionScreen: ScreenType) {
    self.title = title
    self.icon = icon
    self.actionScreen = actionScreen
  }
}
