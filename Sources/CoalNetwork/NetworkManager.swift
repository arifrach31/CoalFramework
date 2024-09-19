//
//  NetworkManager.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//

import Foundation

public class NetworkManager {
  public static let shared = NetworkManager()
  
  public func request<T: Decodable>(endpoint: CoalAPI, responseType: T.Type, completion: @escaping (Result<T, ApiError>) -> Void) {
    let request = endpoint.urlRequest
    NetworkLogger.shared.logRequest(request)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      NetworkLogger.shared.logResponse(response, data: data, error: error)
      if error != nil {
        completion(.failure(.connectionError))
        return
      }
      
      guard let data = data else {
        completion(.failure(.invalidJSONError))
        return
      }
      
      do {
        guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
          completion(.failure(.invalidJSONError))
          return
        }
        
        if let code = jsonResponse["code"] as? Int, code != 200 {
          let message = jsonResponse["message"] as? String
          completion(.failure(.middlewareError(data: jsonResponse, code: code, message: message)))
          return
        }
        
        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(.success(decodedResponse))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(.failedMappingError))
        }
      }
    }
    
    task.resume()
  }
}
