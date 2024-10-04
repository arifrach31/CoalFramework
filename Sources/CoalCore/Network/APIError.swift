//
//  APIError.swift
//  CoalFramework
//
//  Created by ArifRachman on 23/08/24.
//

import Foundation

public enum ApiError: Error {
  case connectionError
  case invalidJSONError
  case middlewareError(data: [String: Any]? = nil, code: Int, message: String?)
  case failedMappingError
  case specifiedError(info: Dictionary<String, Any>)
  
  public var localizedDescription: String {
    switch self {
    case .connectionError:
      return "No internet connection."
    case .invalidJSONError:
      return "The data received from the server is not valid JSON."
    case .middlewareError(_, _, let message):
      return "Error from server: \(message ?? "No message")."
    case .failedMappingError:
      return "Failed to map the data."
    case .specifiedError(let info):
      return "Error details: \(info.debugDescription)."
    }
  }
}
