//
//  LoginModel.swift
//  
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation

public enum LoginType: String, Codable {
  case username
  case email
  case phone
}

public struct LoginModel {}

public struct ForgotButton {
  public var isVisible: Bool?
  public var text: String?
  public var actionScreen: CoalScreenType = .forgot
  
  public init(isVisible: Bool? = true,
              text: String? = nil) {
    self.isVisible = isVisible
    self.text = text
  }
}
