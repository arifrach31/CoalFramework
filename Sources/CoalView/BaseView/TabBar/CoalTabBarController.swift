//
//  CoalTabBarController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import CoalCore

public struct CoalTabInfo {
  public let title: String
  public let icon: UIImage?
  
  public init(title: String, icon: UIImage?) {
    self.title = title
    self.icon = icon
  }
}

public protocol CoalTabInfoProviding {
  func coalTabInfo() -> CoalTabInfo
}

public class CoalTabBarController: UITabBarController {
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
  
  private func setupTabBar() {
    tabBar.tintColor = .black
    tabBar.barTintColor = .white
  }
  
  private func createNavController(for viewController: UIViewController, title: String? = "", icon: UIImage?) -> UINavigationController {
    let navController = UINavigationController(rootViewController: viewController)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = icon?.resize(to: CGSize(width: 20, height: 20))
    return navController
  }
  
  public func addTab(viewController: UIViewController, title: String? = "", icon: UIImage? = nil, atIndex index: Int? = nil) {
    let navController = createNavController(for: viewController, title: title, icon: icon)
    var viewControllers = self.viewControllers ?? []
    
    if let index = index {
      if index >= 0 && index <= viewControllers.count {
        viewControllers.insert(navController, at: index)
      } else {
        viewControllers.append(navController)
      }
    } else {
      viewControllers.append(navController)
    }
    
    self.viewControllers = viewControllers
  }
  
  public func removeTab(atIndex index: Int) {
    guard index >= 0, index < (self.viewControllers?.count ?? 0) else {
      fatalError("Index is out of bounds")
    }
    var viewControllers = self.viewControllers
    viewControllers?.remove(at: index)
    self.viewControllers = viewControllers
  }
  
  public func updateTab(atIndex index: Int, withTitle title: String?, image: UIImage? = nil) {
    guard let navController = self.viewControllers?[safe: index] as? UINavigationController else {
      fatalError("ViewController at index is not a UINavigationController")
    }
    
    if let title = title {
      navController.tabBarItem.title = title
    }
    
    if let image = image {
      navController.tabBarItem.image = image.resize(to: CGSize(width: 20, height: 20))
    }
  }
}

private extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
