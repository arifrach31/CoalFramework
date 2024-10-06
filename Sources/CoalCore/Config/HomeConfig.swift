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
  public var isShowNavBar: Bool?
  
  public init(isShowNavBar: Bool? = false, sections: [HomeSection]? = []) {
    self.isShowNavBar = isShowNavBar
    self.sections = sections
  }
}
