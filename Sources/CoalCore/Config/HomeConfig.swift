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
  public var section: [HomeSectionType]?
  public var isShowNavBar: Bool?
  public var carouselConfig: [CarouselModel]?
  public var categoryConfig: [CategoryModel]?
  public var catalogConfig: [ProductListModel]?
  public var profileConfig: ProfileModel?
  
  public init(
    isShowNavBar: Bool? = false,
    section: [HomeSectionType]? = [],
    carouselConfig: [CarouselModel]? = nil,
    categoryConfig: [CategoryModel]? = nil,
    catalogConfig: [ProductListModel]? = nil,
    profileConfig: ProfileModel? = nil
  ) {
    self.isShowNavBar = isShowNavBar
    self.section = section
    self.carouselConfig = carouselConfig
    self.categoryConfig = categoryConfig
    self.catalogConfig = catalogConfig
    self.profileConfig = profileConfig
  }
}
