//
//  CoalNavigatorProtocol.swift
//
//
//  Created by ArifRachman on 17/09/24.
//

import UIKit
import SwiftUI

public protocol CoalNavigatorProtocol {
  func showInitialPage(isLoggedIn: Bool)
  func showLoginPage()
  func showHomePage()
  func showRegisterPage(backgroundColor: UIColor)
  func showAccountPage()
  func showLoginVerificationMethodPage()
  func pushToViewController<Content: View>(_ swiftUIView: Content)
  func popToPreviousView()
}
