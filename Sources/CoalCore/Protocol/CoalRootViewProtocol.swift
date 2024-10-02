//
//  CoalRootViewProtocol.swift
//
//
//  Created by ArifRachman on 27/09/24.
//

import SwiftUI

public protocol CoalRootViewProtocol {
  func setRootViewController(_ viewController: UIViewController, animated: Bool)
  func setSwiftUIView<Content: View>(_ swiftUIView: Content, backgroundColor: UIColor?)
}

public class CoalRootView: CoalRootViewProtocol {
  private var window: UIWindow
  
  public init(window: UIWindow) {
    self.window = window
  }
  
  public func setRootViewController(_ viewController: UIViewController, animated: Bool) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  public func setSwiftUIView<Content: View>(_ swiftUIView: Content, backgroundColor: UIColor?) {
    let hostingController = UIHostingController(rootView: swiftUIView)
    hostingController.view.backgroundColor = backgroundColor
    setRootViewController(hostingController, animated: false)
  }
}
