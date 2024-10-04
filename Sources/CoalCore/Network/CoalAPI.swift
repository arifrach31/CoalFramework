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
  
  var baseURL: String {
    switch self {
    case .getConfig:
      return NetworkConfig.mockyURL
    default:
      return NetworkConfig.baseURL
    }
  }
  
  var path: String {
    switch self {
    case .login:
      return "/users/v1/login"
    case .getCurrentUser:
      return "/users/v1/me"
    case .getConfig:
      return "mock-up-api"
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
  
  var headers: [String: String]? {
    var headers = ["Content-Type": "application/json"]
    switch self {
    case .getCurrentUser:
      if let token = CoalUser.currentUser?.accessToken {
        headers["Authorization"] = "Bearer \(token)"
      }
    case .login:
      if let userAndPassword = "\(NetworkConfig.BasicAuth.username):\(NetworkConfig.BasicAuth.password)".data(using: .utf8)?.base64EncodedString() {
        headers["Authorization"] = "Basic \(userAndPassword)"
      }
    default:
      return nil
    }
    
    return headers
  }
  
  var urlRequest: URLRequest {
    let url = URL(string: baseURL + path)!
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    
    if let headers = headers {
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
