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
  @StateObject private var viewModel: HomeViewModel
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    VStack(alignment: .center) {
      GeometryReader { geometry in
        CoalCarouselView(currentIndex: $viewModel.currentIndex, cards: viewModel.cards, geometry: geometry)
      }
      .padding(.horizontal, 16)
      .frame(minHeight: 156, maxHeight: 250)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
