//
//  MenuTabItem.swift
//
//
//  Created by ArifRachman on 12/10/24.
//

import SwiftUI

public struct MenuTabItem {
  public var title: String?
  public var icon: String?
  public var actionScreen: AnyView
  
  public init(title: String? = nil, icon: String? = nil, actionScreen: AnyView) {
    self.title = title
    self.icon = icon
    self.actionScreen = actionScreen
  }
}
