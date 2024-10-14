//
//  MenuTabItem.swift
//
//
//  Created by ArifRachman on 12/10/24.
//

import SwiftUI
import UIKit

public enum TabScreen {
  case swiftUIView(AnyView)
  case uiKitViewController(UIViewController)
}

public struct MenuTabItem {
  public var title: String?
  public var icon: String?
  public var screen: TabScreen
  
  public init(title: String? = nil, icon: String? = nil, screen: TabScreen) {
    self.title = title
    self.icon = icon
    self.screen = screen
  }
}
