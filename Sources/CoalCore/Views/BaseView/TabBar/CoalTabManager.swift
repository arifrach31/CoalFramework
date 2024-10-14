//
//  CoalTabManager.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import UIKit
import SwiftUI

public class CoalTabManager: CoalTabProtocol {
  private weak var tabBarController: CoalTabBarController?
  
  public init(tabBarController: CoalTabBarController) {
    self.tabBarController = tabBarController
  }
  
  public func addNewTab(_ items: [MenuTabItem]) {
    let startIndex = tabBarController?.viewControllers?.count ?? 0
    items.enumerated().forEach { index, item in
      addTab(item, at: startIndex + index)
    }
  }
  
  public func addTabs(_ items: [MenuTabItem]) {
    items.enumerated().forEach { index, item in
      addTab(item, at: index)
    }
  }
  
  public func addTab(_ item: MenuTabItem, at index: Int) {
    switch item.screen {
    case .swiftUIView(let swiftUIView):
      let hostingController = UIHostingController(rootView: swiftUIView)
      tabBarController?.addTab(viewController: hostingController, title: item.title, icon: UIImage(named: item.icon ?? "", in: .module, with: nil), atIndex: index)
    case .uiKitViewController(let viewController):
      tabBarController?.addTab(viewController: viewController, title: item.title, icon: UIImage(named: item.icon ?? "", in: .module, with: nil), atIndex: index)
    }
  }
  
  public func removeTab(at index: Int) {
    tabBarController?.removeTab(atIndex: index)
  }
  
  public func updateTab(at index: Int, title: String?, icon: UIImage?) {
    tabBarController?.updateTab(atIndex: index, withTitle: title, image: icon)
  }
  
  public func navigateToTab(at index: Int) {
    guard let tabBarController = tabBarController else {
      print("TabBarController not found")
      return
    }
    
    guard index >= 0 && index < (tabBarController.viewControllers?.count ?? 0) else {
      print("Index is out of bounds.")
      return
    }
    
    tabBarController.selectedIndex = index
  }
  
  public func setShowTabBar(isShowTab: Bool = false) {
    tabBarController?.setTabBar(isShow: isShowTab)
  }
}
