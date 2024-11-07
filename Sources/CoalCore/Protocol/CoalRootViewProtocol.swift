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
  
  public var currentViewController: UIViewController? {
    return (window?.rootViewController as? UINavigationController)?.topViewController
  }
  
  public init(windowScene: UIWindowScene) {
    self.windowScene = windowScene
  }
  
  public func setRootViewController(_ viewController: UIViewController) {
    let navigationController = UINavigationController(rootViewController: viewController)
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  public func setSwiftUIView<Content: View>(_ swiftUIView: Content) {
    let hostingController = UIHostingController(rootView: swiftUIView.environmentObject(ToastManager.shared))
    setRootViewController(hostingController)
  }
  
  public func pushViewController<Content: View>(_ swiftUIView: Content) {
    guard let navigationController = currentViewController?.navigationController else {
      print("NavigationController not found.")
      return
    }
    let viewController = UIHostingController(rootView: swiftUIView.environmentObject(ToastManager.shared))
    navigationController.pushViewController(viewController, animated: false)
  }
  
  public func popViewController(animated: Bool) {
    currentViewController?.navigationController?.popViewController(animated: animated)
  }
}
