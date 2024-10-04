//
//  ConfigModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 22/08/24.
//

import Foundation

public struct ConfigModel: Codable {
  public let project: ConfigProject?
  public let pages: ConfigPages?
  
  public func save() {
    CoalPersistent.shared.setCodable(key: .coalFramework, value: self)
  }
  
  public static func clear() {
    CoalPersistent.shared.delete(key: .coalFramework)
  }
  
  public static var currentConfig: ConfigModel? {
    return CoalPersistent.shared.getCodable(key: .coalFramework, type: ConfigModel.self)
  }
}

public struct ConfigProject: Codable {
  public let name: String
  public let description: String
}

public struct ConfigPages: Codable {
  public let login: ConfigPage?
  public let register: ConfigPage?
  public let home: ConfigHomePage?
}

public struct ConfigPage: Codable {
  public let header: ConfigHeader?
  public let fields: [ConfigField]?
}

public struct ConfigHomePage: Codable {
  public let header: ConfigHeader?
  public let menu: [ConfigMenuItem]?
}

public struct ConfigHeader: Codable {
  public let title: String?
  public let description: String?
  public let image: String?
}

public enum ConfigFieldType: String, Codable {
  case text
  case email
  case phone
  case password
  case number
  case date
  case checkbox
  case submit
}

public struct ConfigField: Codable, Identifiable {
  public let id: Int?
  public let type: ConfigFieldType
  public let label: String?
  public let placeholder: String?
}

public struct ConfigMenuItem: Codable {
  public let id: String
  public let name: String
  public let url: String
  public let icon: String
}
