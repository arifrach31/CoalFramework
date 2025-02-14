//
//  HomeModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import Foundation

public protocol HomeSectionProvider {
  func getCarousel() -> [CarouselModel]
  func getCategories() -> [CategoryModel]
  func getProductList() -> [ProductListModel]
}

public enum HomeSectionType: Identifiable {
  case carousel
  case category
  case productList
  case profile
  
  public var id: String {
    switch self {
    case .carousel:
      return "carousel"
    case .category:
      return "category"
    case .productList:
      return "productList"
    case .profile:
      return "profile"
    }
  }
}

public struct CarouselModel: Identifiable {
  public let id: UUID
  public var image: String
  public var url: String
  
  public init(
    id: UUID = UUID(),
    image: String = "",
    url: String = ""
  ) {
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
  public var titleSection: String
  public var actionTitleSection: String
  public var layoutType: LayoutDirectionType
  public var gridRows: Int
  public var iconSize: CGFloat
  public var cardSize: CGFloat
  
  public init(
    id: UUID = UUID(),
    background: String = "",
    icon: String = "",
    title: String = "",
    titleSection: String = CoalString.category,
    actionTitleSection: String = CoalString.seeAll,
    layoutType: LayoutDirectionType = .horizontal,
    gridRows: Int = 1,
    iconSize: CGFloat = 30,
    cardSize: CGFloat = 60
  ) {
    self.id = id
    self.background = background
    self.icon = icon
    self.title = title
    self.titleSection = titleSection
    self.actionTitleSection = actionTitleSection
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.iconSize = iconSize
    self.cardSize = cardSize
  }
}

public struct ProductListModel: Identifiable {
  public let id: UUID
  public var image: String
  public var category: String
  public var title: String
  public var description: String
  public var titleSection: String
  public var actionTitleSection: String
  public var layoutType: LayoutDirectionType
  public var gridRows: Int
  public var imgSize: CGFloat
  public var cardSize: CGFloat
  
  public init(
    id: UUID = UUID(),
    image: String = "",
    category: String = "",
    title: String = "",
    description: String = "",
    titleSection: String = CoalString.productList,
    actionTitleSection: String = CoalString.seeAll,
    layoutType: LayoutDirectionType = .vertical,
    gridRows: Int = 2,
    imgSize: CGFloat = 120,
    cardSize: CGFloat = 240
  ) {
    self.id = id
    self.image = image
    self.category = category
    self.title = title
    self.description = description
    self.titleSection = titleSection
    self.actionTitleSection = actionTitleSection
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.imgSize = imgSize
    self.cardSize = cardSize
  }
}
