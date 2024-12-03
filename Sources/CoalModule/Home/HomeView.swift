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
      if let homeSection = config.homeConfig?.section {
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
        cards: carouselConfig
      )
    case .category:
      let categoryConfig = config.homeConfig?.categoryConfig
      CoalGridCategoryView(
        categories: categoryConfig
      )
      
    case .productList:
      let catalogConfig = config.homeConfig?.catalogConfig
      CoalGridCatalogView(
        catalog: catalogConfig
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
