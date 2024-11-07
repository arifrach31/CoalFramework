//
//  RegisterModel.swift
//  
//
//  Created by M. Rizki Maulana on 06/11/24.
//

import Foundation

public struct RegisterModel: Codable {
  public var token: String?
  public var refreshToken: String?
  public var email: String?
  public var phoneNumber: String?
}
