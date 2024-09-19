//
//  CarouselItemModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public struct CarouselModel: Identifiable {
  public let id: Int
  public var color: Color
  public var page: CardPage
  
  public init(id: Int, color: Color, page: CardPage) {
    self.id = id
    self.color = color
    self.page = page
  }
}

public enum CardPage: String {
  case pageOne = "Page One"
  case pageTwo = "Page Two"
  case pageThree = "Page Three"
}
