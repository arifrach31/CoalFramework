//
//  CarouselModel.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

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
