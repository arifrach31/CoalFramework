//
//  CoalPersistent.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/08/24.
//


import Foundation

public enum PersistentKey: String {
  case generalUser
  case coalFramework
}

public struct CoalPersistent {
  public static let shared = CoalPersistent()
  
  private let userDefaults = UserDefaults.standard
  
  private init() {}
  
  public func set(key: PersistentKey, value: String) {
    userDefaults.set(value, forKey: key.rawValue)
  }
  
  public func get(key: PersistentKey) -> String? {
    return userDefaults.string(forKey: key.rawValue)
  }
  
  public func delete(key: PersistentKey) {
    userDefaults.removeObject(forKey: key.rawValue)
  }
  
  public func setCodable<T: Codable>(key: PersistentKey, value: T) {
    let encoder = JSONEncoder()
    if let data = try? encoder.encode(value) {
      userDefaults.set(data, forKey: key.rawValue)
    }
  }
  
  public func getCodable<T: Codable>(key: PersistentKey, type: T.Type) -> T? {
    if let data = userDefaults.data(forKey: key.rawValue) {
      let decoder = JSONDecoder()
      return try? decoder.decode(T.self, from: data)
    }
    return nil
  }
}
