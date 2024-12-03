//
//  NetworkConfig.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import Foundation

public protocol NetworkConfigProvider {
  func getConfig() -> NetworkConfig
}

public struct NetworkConfig: NetworkConfigProvider {
  public var baseURL: String
  public var basicAuth: BasicAuthConfig
  
  public init(
    baseURL: String = "",
    basicAuth: BasicAuthConfig = BasicAuthConfig()
  ) {
    self.baseURL = baseURL
    self.basicAuth = basicAuth
  }
  
  public func getConfig() -> NetworkConfig {
    return self
  }
}

public struct BasicAuthConfig {
  public var username: String
  public var password: String
  
  public init(
    username: String = "",
    password: String = ""
  ) {
    self.username = username
    self.password = password
  }
}

