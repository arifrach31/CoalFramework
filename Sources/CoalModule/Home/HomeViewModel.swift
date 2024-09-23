//
//  HomeViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import Combine
import CoalModel

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


class HomeViewModel: ObservableObject {
  @Published var currentIndex: Int = 0
}
