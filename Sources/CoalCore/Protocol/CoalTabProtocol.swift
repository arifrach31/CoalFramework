//
//  CoalTabProtocol.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI

public protocol CoalTabProtocol {
  func setShowTabBar(isShowTab: Bool)
  func addNewTab(_ item: [MenuTabItem])
  func addTabs(_ items: [MenuTabItem])
  func addTab(_ item: MenuTabItem, at index: Int)
  func removeTab(at index: Int)
  func updateTab(at index: Int, title: String?, icon: UIImage?)
  func navigateToTab(at index: Int)
}
