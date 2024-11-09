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
  private var coalEnvironment: CoalEnvironment
  
  public var currentViewController: UIViewController? {
    return (window?.rootViewController as? UINavigationController)?.topViewController
  }
  
  public init(windowScene: UIWindowScene, coalEnvironment: CoalEnvironment) {
    self.windowScene = windowScene
    self.coalEnvironment = coalEnvironment
  }
  
  public func setRootViewController(_ viewController: UIViewController) {
    if let existingNavController = window?.rootViewController as? UINavigationController {
      existingNavController.setViewControllers([viewController], animated: false)
    } else {
      let navigationController = UINavigationController(rootViewController: viewController)
      window = UIWindow(windowScene: windowScene)
      window?.rootViewController = navigationController
      window?.makeKeyAndVisible()
    }
  }
  
  public func setSwiftUIView<Content: View>(_ swiftUIView: Content) {
    let hostingController = UIHostingController(rootView: swiftUIView.environmentObject(coalEnvironment))
    setRootViewController(hostingController)
  }
  
  public func pushViewController<Content: View>(_ swiftUIView: Content) {
    guard let navigationController = currentViewController?.navigationController else {
      print("NavigationController not found.")
      return
    }
    let viewController = UIHostingController(rootView: swiftUIView.environmentObject(coalEnvironment))
    navigationController.pushViewController(viewController, animated: false)
  }
  
  public func popViewController(animated: Bool) {
    currentViewController?.navigationController?.popViewController(animated: animated)
  }
}
