//
//  CoalNavigatorProtocol.swift
//
//
//  Created by ArifRachman on 17/09/24.
//

import UIKit

public protocol CoalNavigatorProtocol {
  func showInitialPage(isLoggedIn: Bool)
  func showLoginPage()
  func showHomePage()
  func showRegisterPage(backgroundColor: UIColor)
  func showAccountPage()
}
