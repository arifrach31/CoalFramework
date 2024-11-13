//
//  CoalScreen.swift
//  CoalFramework
//
//  Created by ArifRachman on 28/10/24.
//

import Foundation

public enum CoalScreenType {
  case splash
  case login
  case register
  case home
  case verificationMethod
  case verificationCode(journey: VerificationType?, methodField: ConfigField?)
  case account
  case forgot
  case changePassword
  case webview(model: WebViewModel?)
}
