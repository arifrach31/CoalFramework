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
  case sendOTP(
    channel: String,
    sendTo: String,
    timeStamp: String,
    nonce: String,
    signature: String
  )
  case verifyOTP(sendTo: String, otp: String)
  case register(
    fullname: String,
    email: String,
    password: String,
    confirmPassword: String,
    mobileNumber: String
  )
  case forgotPassword(email: String)
  
  var path: String {
    switch self {
    case .login:
      return "/users/v1/login"
    case .getCurrentUser:
      return "/users/v1/me"
    case .getConfig:
      return "/config/project"
    case .sendOTP:
      return "/user/v1/otp"
    case .verifyOTP:
      return "/user/v1/verify"
    case .register:
      return "/users/v1/register"
    case .forgotPassword:
      return "/user/v1/forgot-password"
    }
  }
  
  var method: String {
    switch self {
    case .login,
        .sendOTP,
        .verifyOTP,
        .register,
        .forgotPassword:
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
    case .sendOTP(
      let channel,
      let sendTo,
      let timeStamp,
      let nonce,
      let signature
    ):
      return [
        "channel": channel,
        "sendTo": sendTo,
        "timeStamp": timeStamp,
        "nonce": nonce,
        "signature": signature
      ]
    case .verifyOTP(let sendTo, let otp):
      return [
        "sendTo": sendTo,
        "otp": otp
      ]
    case .register(
      let fullname,
      let email,
      let password,
      let confirmPassword,
      let mobileNumber
    ):
      return [
        "fullname": fullname,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "mobileNumber": mobileNumber
      ]
    case .forgotPassword(let email):
      return ["email": email]
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
