//
//  HomeViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import Combine
import CoalModel

class HomeViewModel: ObservableObject {
  @Published var currentIndex: Int = 0
  
  let cards: [CarouselModel] = [
    CarouselModel(id: 0, color: .red, page: .pageOne, url: "https://www.apple.com"),
    CarouselModel(id: 1, color: .blue, page: .pageTwo),
    CarouselModel(id: 2, color: .pink, page: .pageThree, url: "https://www.apple.com"),
    CarouselModel(id: 3, color: .purple, page: .pageFour, url: "https://www.apple.com")
  ]
  
}
