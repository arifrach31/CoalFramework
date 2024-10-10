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
        self.navigator?.showInitialPage(isLoggedIn: false)
      },
      isShowNavBar: config?.isShowNavBar ?? false
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
        if let categoryConfig = config?.categoryConfig {
          CoalGridCategoryView(categories: items, layoutType: categoryConfig.layoutType, gridRows: categoryConfig.gridRows, title: categoryConfig.title)
        } else {
          CoalGridCategoryView(categories: items, layoutType: .horizontal, gridRows: 1, title: "Category")
        }
      } else {
        Text("Category Section")
      }
    case .productList(let items):
      if !items.isEmpty {
        if let catalogConfig = config?.catalogConfig {
          CoalGridCatalogView(catalog: items, layoutType: catalogConfig.layoutType, gridRows: catalogConfig.gridRows, title: catalogConfig.title)
        } else {
          CoalGridCatalogView(catalog: items, layoutType: .vertical, gridRows: 2, title: "Product List")
        }
      } else {
        Text("Product List Section")
          .padding()
      }
    }
  }
}

//struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView(config: HomeConfig())
//  }
//}

extension HomeView: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: CoalString.home, icon: UIImage.icHome)
  }
}
