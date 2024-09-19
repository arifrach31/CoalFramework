//
//  CoalNotifications.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import Foundation

public struct CoalNotifications {
  public static let userDidLogout = NSNotification.Name(rawValue: "userDidLogout")
}

public extension NSNotification.Name {
  func post(with object: Any? = nil) {
    NotificationCenter.default.post(name: self, object: object)
  }
}
