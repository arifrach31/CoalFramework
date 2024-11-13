//
//  CoalNavigatorProtocol.swift
//
//
//  Created by ArifRachman on 17/09/24.
//

import SwiftUI

public protocol CoalNavigatorProtocol {
  func pushToViewController<Content: View>(_ swiftUIView: Content)
  func popToPreviousView()
  
  func showInitialPage(isLoggedIn: Bool)
  func goTo(_ screen: CoalScreenType)
}
