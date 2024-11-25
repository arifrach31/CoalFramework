//
//  HomeView.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import CoalCore

public struct HomeView: View {
  @EnvironmentObject var config: CoalConfig
  @StateObject private var viewModel: HomeViewModel
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    CoalBaseView(
      pageType: .home,
      rightAction: {
        navigator?.goTo(.login)
      },
      isShowNavBar: config.homeConfig?.isShowNavBar ?? false,
      isScrollView: true
    ) {
      if let homeSection = config.homeConfig?.sections {
        ForEach(homeSection, id: \.id) { section in
          sectionView(for: section)
        }
      }
    }
  }
  
  @ViewBuilder
  private func sectionView(for section: HomeSectionType) -> some View {
    switch section {
    case .carousel:
      let carouselConfig = config.homeConfig?.carouselConfig
      CoalCarouselView(
        cards: carouselConfig?.cards,
        cardHeight: carouselConfig?.cardHeight,
        didSelectItem: carouselConfig?.didSelectItem
      )
      
    case .category:
      let categoryConfig = config.homeConfig?.categoryConfig
      CoalGridCategoryView(
        categories: categoryConfig?.categories ?? [],
        layoutType: categoryConfig?.layoutType ?? .horizontal,
        gridRows: categoryConfig?.gridRows ?? 1,
        title: categoryConfig?.title ?? CoalString.category,
        actionTitle: categoryConfig?.actionTitle ?? CoalString.seeAll,
        iconSize: categoryConfig?.iconSize ?? 30,
        cardSize: categoryConfig?.cardSize ?? 60,
        didSelectSeeAll: categoryConfig?.didSelectSeeAll ?? {},
        didSelectItem: categoryConfig?.didSelectItem ?? {_ in}
      )
      
    case .productList:
      let catalogConfig = config.homeConfig?.catalogConfig
      CoalGridCatalogView(
        catalog: catalogConfig?.catalog ?? [],
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

#Preview {
  HomeView()
}

extension HomeView: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: CoalString.home, icon: UIImage.icHome?.imageName)
  }
}
