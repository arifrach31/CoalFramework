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
  
  public init(baseURL: String =
                "https://raw.githubusercontent.com/emrizkiem/emrizkiem.github.io/master/",
              basicAuth: BasicAuthConfig = BasicAuthConfig()) {
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
  
  public init(username: String = "microsservice-user", 
              password: String = "0b7a0c3d38cfeed158e210cf235594d129e8f8e38") {
    self.username = username
    self.password = password
  }
}

