//
//  HomeView.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import CoalCore

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel
  public var navigator: CoalNavigatorProtocol?
  public let config: HomeConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: HomeConfig?) {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    CoalBaseView(
      pageType: .home,
      rightAction: {
        self.navigator?.showInitialPage(isLoggedIn: false, backgroundColor: .white)
      }
    ) {
      ScrollView {
        VStack(alignment: .center) {
          if let homeSection = config?.sections {
            ForEach(homeSection, id: \.id) { section in
              sectionView(for: section)
            }
          }
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
        .padding(.vertical, 50)
      } else {
        Text("Carousel Section")
      }
    case .category(let items):
      if !items.isEmpty {
        CoalListView(category: items, layoutType: .horizontal, horizontalRows: 1)
      } else {
        Text("Category Section")
      }
    case .productList(let items):
      if !items.isEmpty {
        CoalListView(catalog: items, layoutType: .vertical, verticalRows: 2)
      } else {
        Text("Product List Section")
          .padding()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(config: HomeConfig())
  }
}

extension HomeView: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: CoalString.home, icon: UIImage.icHome)
  }
}
