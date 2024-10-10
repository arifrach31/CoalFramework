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
      if items.isEmpty {
        Text("Carousel Section")
      } else {
        let carouselConfig = config?.carouselConfig
        GeometryReader { geometry in
          CoalCarouselView(
            currentIndex: carouselConfig?.$currentIndex ?? $viewModel.currentIndex,
            cards: carouselConfig?.cards ?? items,
            geometry: carouselConfig?.geometry ?? geometry,
            cardHeight: carouselConfig?.cardHeight ?? 188,
            action: carouselConfig?.action ?? {}
          )
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 150, maxHeight: 190)
        .padding(.vertical, 50)
      }
    case .category(let items):
      if items.isEmpty {
        Text("Category Section")
      } else {
        let categoryConfig = config?.categoryConfig
        CoalGridCategoryView(
          categories: categoryConfig?.categories ?? items,
          layoutType: categoryConfig?.layoutType ?? .horizontal,
          gridRows: categoryConfig?.gridRows ?? 1,
          title: categoryConfig?.title ?? CoalString.category,
          actionTitle: categoryConfig?.actionTitle ?? CoalString.seeAll,
          iconSize: categoryConfig?.iconSize ?? 30,
          cardSize: categoryConfig?.cardSize ?? 60,
          didSelectSeeAll: categoryConfig?.didSelectSeeAll ?? {},
          didSelectItem: categoryConfig?.didSelectItem ?? {_ in}
        )
      }
    case .productList(let items):
      if items.isEmpty {
        Text("Product List Section")
          .padding()
      } else {
        let catalogConfig = config?.catalogConfig
        CoalGridCatalogView(
          catalog: catalogConfig?.catalog ?? items,
          layoutType: catalogConfig?.layoutType ?? .vertical,
          gridRows: catalogConfig?.gridRows ?? 2,
          imgSize: catalogConfig?.imgSize ?? 120,
          cardSize: catalogConfig?.cardSize ?? 240,
          title: catalogConfig?.title ?? CoalString.productList,
          actionTitle: catalogConfig?.actionTitle ?? CoalString.seeAll,
          didSelectSeeAll: catalogConfig?.didSelectSeeAll ?? {},
          didSelectItem: catalogConfig?.didSelectItem ?? {_ in}
        )
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
