//
//  MenuTabItem.swift
//
//
//  Created by ArifRachman on 12/10/24.
//

import SwiftUI
import UIKit

public struct MenuTabItem {
  public var title: String?
  public var icon: String?
  public var viewScreen: ViewScreenType
  
  public init(
    title: String? = nil,
    icon: String? = nil,
    viewScreen: ViewScreenType
  ) {
    self.title = title
    self.icon = icon
    self.viewScreen = viewScreen
  }
}
