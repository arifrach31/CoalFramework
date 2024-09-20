//
//  CarouselModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public struct CarouselModel: Identifiable {
  public let id: Int
  public var color: Color
  public var image: String
  public var page: CardPage
  public var url: String
  
  public init(id: Int, color: Color, page: CardPage, image: String = "", url: String = "") {
    self.id = id
    self.color = color
    self.page = page
    self.image = image
    self.url = url
  }
}

public enum CardPage: String {
  case pageOne = "Page One"
  case pageTwo = "Page Two"
  case pageThree = "Page Three"
  case pageFour = "Page Four"
}
