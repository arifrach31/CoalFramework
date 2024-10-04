//
//  HomeModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import Foundation

public protocol HomeSectionProvider {
  func getCarouselItems() -> [CarouselModel]
  func getCategories() -> [CategoryModel]
  func getProductList() -> [ProductListModel]
}

public enum HomeSection: Identifiable {
  case carousel(items: [CarouselModel])
  case category(items: [CategoryModel])
  case productList(items: [ProductListModel])
  
  public var id: String {
    switch self {
    case .carousel:
      return "carousel"
    case .category:
      return "category"
    case .productList:
      return "productList"
    }
  }
}

public struct CarouselModel: Identifiable {
  public let id: UUID
  public var image: String
  public var url: String
  
  public init(id: UUID = UUID(), image: String = "", url: String = "") {
    self.id = id
    self.image = image
    self.url = url
  }
}

public struct CategoryModel: Identifiable {
  public let id: UUID
  public var background: String
  public var icon: String
  public var title: String
  
  public init(id: UUID = UUID(), background: String = "", icon: String = "", title: String = "") {
    self.id = id
    self.background = background
    self.icon = icon
    self.title = title
  }
}

public struct ProductListModel: Identifiable {
  public let id: UUID
  public var image: String
  public var category: String
  public var title: String
  public var description: String
  
  public init(id: UUID = UUID(), image: String = "", category: String = "", title: String = "", description: String = "") {
    self.id = id
    self.image = image
    self.category = category
    self.title = title
    self.description = description
  }
}
