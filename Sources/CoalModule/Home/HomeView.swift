//
//  HomeView.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import CoalCore
import CoalModel
import CoalView

public struct HomeView: View {
  public let sections: [HomeSection]
  @StateObject private var viewModel: HomeViewModel
    public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil, sections: [HomeSection] = []) {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
    self.navigator = navigator
    self.sections = sections
  }
  
  public var body: some View {
    ScrollView {
      VStack(alignment: .center) {
        ForEach(sections, id: \.id) { section in
          sectionView(for: section)
        }
      }
    }
  }
  
  @ViewBuilder
  private func sectionView(for section: HomeSection) -> some View {
    switch section {
    case .carousel(let items):
      if !items.isEmpty {
        GeometryReader { geometry in
          CoalCarouselView(currentIndex: $viewModel.currentIndex, cards: items, geometry: geometry)
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 150, maxHeight: 190)
      } else {
        Text("No Carousel")
      }
    case .category:
      Text("Category Section")
        .padding()
    case .productList:
      Text("Product List Section")
        .padding(.vertical, 50)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(sections: [
      .carousel(items: [CarouselModel()]),
      .category,
      .productList
    ])
  }
}
