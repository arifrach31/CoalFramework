//
//  CoalTabManager.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI

public class CoalTabManager: CoalTabProtocol {
  private weak var tabBarController: CoalTabBarController?
  
  public init(tabBarController: CoalTabBarController) {
    self.tabBarController = tabBarController
  }
  
  public func addTabs(_ views: [any View]) {
    views.enumerated().forEach { index, view in
      addTab(view, at: index)
    }
  }
  
  public func addTab<Content: View>(_ view: Content, at index: Int) {
    let hostingController = UIHostingController(rootView: view)
    if let tabInfo = (view as? CoalTabInfoProviding)?.coalTabInfo() {
      tabBarController?.addTab(viewController: hostingController, title: tabInfo.title, icon: tabInfo.icon, atIndex: index)
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
}
