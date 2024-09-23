//
//  CarouselModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public enum HomeSection: Identifiable {
  case carousel(items: [CarouselModel])
  case category
  case productList
  
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
