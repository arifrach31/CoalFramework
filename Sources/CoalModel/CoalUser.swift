//
//  CoalUser.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import CoalCore

public struct CoalUser: Codable {
  public var accessToken: String?
  public var refreshToken: String?
  public var data: UserData?
  
  public func save() {
    CoalPersistent.shared.setCodable(key: .generalUser, value: self)
  }
  
  public static func clear() {
    CoalPersistent.shared.delete(key: .generalUser)
  }
  
  public static var currentUser: CoalUser? {
    return CoalPersistent.shared.getCodable(key: .generalUser, type: CoalUser.self)
  }
}

public struct UserData: Codable {
  public let email: String
  public let username: String
  public let fullname: String
  public let mobileNumber: String
}
