//
//  CoalTabManager.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI

public class CoalTabManager: ObservableObject {
  @Published public var tabs: [MenuTabItem] = []
  @Published public var selectedTab: Int = 0
  @Published public var isTabBarVisible: Bool = true
  
  public init() {}
  
  public func addTab(_ item: MenuTabItem) {
    tabs.append(item)
  }
  
  public func removeTab(at index: Int) {
    guard index >= 0 && index < tabs.count else { return }
    tabs.remove(at: index)
  }
  
  public func updateTab(at index: Int, withTitle title: String?, icon: String?) {
    guard index >= 0 && index < tabs.count else { return }
    tabs[index].title = title ?? tabs[index].title
    tabs[index].icon = icon ?? tabs[index].icon
  }
  
  public func navigateToTab(at index: Int) {
    guard index >= 0 && index < tabs.count else { return }
    selectedTab = index
  }
  
  public func setShowTabBar(_ isShow: Bool) {
    isTabBarVisible = isShow
  }
}
