//
//  CoalRootViewProtocol.swift
//
//
//  Created by ArifRachman on 27/09/24.
//

import SwiftUI

public protocol CoalRootViewProtocol {
  func setRootViewController(_ viewController: UIViewController, animated: Bool)
  func setSwiftUIView<Content: View>(_ swiftUIView: Content)
}

public class CoalRootView: CoalRootViewProtocol {
  private var windowScene: UIWindowScene
  private var window: UIWindow?
  
  public init(windowScene: UIWindowScene) {
    self.windowScene = windowScene
  }
  
  public func setRootViewController(_ viewController: UIViewController, animated: Bool) {
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
  }
  
  public func setSwiftUIView<Content: View>(_ swiftUIView: Content) {
    let hostingController = UIHostingController(rootView: swiftUIView)
    setRootViewController(hostingController, animated: false)
  }
}
