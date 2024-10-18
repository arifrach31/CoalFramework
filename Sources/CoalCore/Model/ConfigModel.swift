//
//  ConfigModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 22/08/24.
//

import Foundation
import SwiftUI

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
  
  public init(title: String? = nil,
              description: String? = nil,
              image: String? = nil) {
    self.title = title
    self.description = description
    self.image = image
  }
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
  public var isShowError: Bool
  public let errorMessage: String?
  public let labelColor: String?
  public let backgroundColor: String?
  
  public init(
    id: Int? = nil,
    type: ConfigFieldType,
    label: String? = nil,
    placeholder: String? = nil,
    errorMessage: String? = nil,
    isShowError: Bool = false,
    labelColor: String? = nil,
    backgroundColor: String? = nil
  ) {
    self.id = id
    self.type = type
    self.label = label
    self.placeholder = placeholder
    self.isShowError = isShowError
    self.errorMessage = errorMessage
    self.labelColor = labelColor
    self.backgroundColor = backgroundColor
  }
  
  public var titleVerification: String {
    switch type {
    case .email:
      return CoalString.localized(forKey: "email_to", maskingAccount(label ?? "", type: .email))
    case .phone:
      return CoalString.localized(forKey: "sms_to", maskingAccount(label ?? "", type: .phone))
    default:
      return label ?? "-"
    }
  }
  
  public var iconVerification: Image {
    switch type {
    case .email: return .emailIcon
    case .phone: return .phoneIcon
    default: return .unknownIcon
    }
  }
}

public struct ConfigMenuItem: Codable {
  public let id: String
  public let name: String
  public let url: String
  public let icon: String
}
