//
//  BaseResponseModel.swift
//
//
//  Created by ArifRachman on 23/10/24.
//

import Foundation

public struct BaseResponseModel<T: Codable>: Codable {
  public let success: Bool
  public let message: String
  public let data: T?
  
  public init(
    success: Bool,
    message: String,
    data: T?
  ) {
    self.success = success
    self.message = message
    self.data = data
  }
}
