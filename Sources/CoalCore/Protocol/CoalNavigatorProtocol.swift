//
//  CoalNavigatorProtocol.swift
//
//
//  Created by ArifRachman on 17/09/24.
//

import UIKit

public protocol CoalNavigatorProtocol {
  func showInitialPage(isLoggedIn: Bool, backgroundColor: UIColor)
  func showLoginPage(backgroundColor: UIColor, clientLogoName: String?)
  func showHomePage(backgroundColor: UIColor)
  func showRegisterPage(backgroundColor: UIColor)
}
