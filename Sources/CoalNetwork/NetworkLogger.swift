//
//  NetworkLogger.swift
//  CoalFramework
//
//  Created by ArifRachman on 23/08/24.
//

import Foundation

class NetworkLogger {
  static let shared = NetworkLogger()
  
  private let separator = "----------------------------------------"
  
  func logRequest(_ request: URLRequest) {
    print(separator)
    print("🚀 Request:")
    print("URL: \(request.url?.absoluteString ?? "No URL")")
    print("Method: \(request.httpMethod ?? "No Method")")
    if let headers = request.allHTTPHeaderFields {
      print("Headers: \(headers)")
    }
    if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
      print("Body: \(bodyString)")
    }
    print(separator)
  }
  
  func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
    print(separator)
    print("🎯 Response:")
    if let error = error {
      print("Error: \(error.localizedDescription)")
      print(separator)
      return
    }
    
    guard let httpResponse = response as? HTTPURLResponse else {
      print("No HTTP response")
      print(separator)
      return
    }
    
    print("Status Code: \(httpResponse.statusCode)")
    if let headers = httpResponse.allHeaderFields as? [String: Any] {
      print("Headers: \(headers)")
    }
    
    if let data = data, let dataString = String(data: data, encoding: .utf8) {
      print("Data: \(dataString)")
    }
    print(separator)
  }
}
