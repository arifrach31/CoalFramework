//
//  CoalAPI.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import Foundation

public enum CoalAPI {
  case login(username: String, password: String)
  case getCurrentUser
  case getConfig
  
  var path: String {
    switch self {
    case .login:
      return "/users/v1/login"
    case .getCurrentUser:
      return "/users/v1/me"
    case .getConfig:
      return "/config/project"
    }
  }
  
  var method: String {
    switch self {
    case .login:
      return "POST"
    case .getCurrentUser, .getConfig:
      return "GET"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .login(let username, let password):
      return ["username": username,
              "password": password]
    default:
      return nil
    }
  }
  
  func headers(using config: NetworkConfig) -> [String: String]? {
    var headers = ["Content-Type": "application/json"]
    switch self {
    case .getCurrentUser:
      if let token = CoalUser.currentUser?.accessToken {
        headers["Authorization"] = "Bearer \(token)"
      }
    case .login:
      let userAndPassword = "\(config.basicAuth.username):\(config.basicAuth.password)"
      if let userAndPasswordData = userAndPassword.data(using: .utf8) {
        headers["Authorization"] = "Basic \(userAndPasswordData.base64EncodedString())"
      }

    default:
      return nil
    }
    
    return headers.isEmpty ? nil : headers
  }
  
  public func urlRequest(using configProvider: NetworkConfigProvider) throws -> URLRequest {
    let config = configProvider.getConfig()
    let url = URL(string: config.baseURL + path)!
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if let headers = self.headers(using: config) {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }
    
    if let parameters = parameters, method == "POST" {
      request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }
    
    return request
  }
}
