//
//  CoalRootViewProtocol.swift
//
//
//  Created by ArifRachman on 27/09/24.
//

import SwiftUI

public protocol CoalRootViewProtocol {
  var currentViewController: UIViewController? { get }
  
  func setRootViewController(_ viewController: UIViewController)
  func setSwiftUIView<Content: View>(_ swiftUIView: Content)
  func pushViewController<Content: View>(_ swiftUIView: Content)
  func popViewController(animated: Bool)
}

public class CoalRootView: CoalRootViewProtocol {
  private var windowScene: UIWindowScene
  private var window: UIWindow?
  
  public var currentViewController: UIViewController?
  
  public init(windowScene: UIWindowScene) {
    self.windowScene = windowScene
  }
  
  public func setRootViewController(_ viewController: UIViewController) {
    let navigationController = UINavigationController(rootViewController: viewController)
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    currentViewController = viewController
  }
  
  public func setSwiftUIView<Content: View>(_ swiftUIView: Content) {
    let hostingController = UIHostingController(rootView: swiftUIView)
    setRootViewController(hostingController)
  }
  
  public func pushViewController<Content: View>(_ swiftUIView: Content) {
    let viewController = UIHostingController(rootView: swiftUIView)
    
    guard let navigationController = window?.rootViewController as? UINavigationController else {
      print("NavigationController not found.")
      return
    }
    navigationController.pushViewController(viewController, animated: false)
    currentViewController = viewController
  }
  
  public func popViewController(animated: Bool) {
    guard let navigationController = window?.rootViewController as? UINavigationController else {
      print("NavigationController not found.")
      return
    }
    navigationController.popViewController(animated: animated)
    currentViewController = navigationController.topViewController
  }
}
