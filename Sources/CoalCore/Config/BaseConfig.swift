//
//  BaseConfig.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation

public class BaseConfig {
  public var backgroundImageName: String?
  public var backgroundColor: String?
  
  public init(backgroundImageName: String? = nil, backgroundColor: String? = nil) {
    self.backgroundImageName = backgroundImageName
    self.backgroundColor = backgroundColor
  }
}
