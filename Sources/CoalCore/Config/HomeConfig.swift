//
//  HomeConfig.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import Foundation

public protocol HomeConfigProvider {
  func getConfig() -> HomeConfig
}

public class HomeConfig {
  public var sections: [HomeSection]?
  
  public init(sections: [HomeSection]? = []) {
    self.sections = sections
  }
}
