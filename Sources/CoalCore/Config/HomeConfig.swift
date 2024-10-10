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
  public var carouselConfig: CoalCarouselView?
  public var categoryConfig: CoalGridCategoryView?
  public var catalogConfig: CoalGridCatalogView?
  
  public init(isShowNavBar: Bool? = false, sections: [HomeSection]? = [], carouselConfig: CoalCarouselView? = nil, categoryConfig: CoalGridCategoryView? = nil, catalogConfig: CoalGridCatalogView? = nil) {
    self.isShowNavBar = isShowNavBar
    self.sections = sections
    self.carouselConfig = carouselConfig
    self.categoryConfig = categoryConfig
    self.catalogConfig = catalogConfig
  }
}
