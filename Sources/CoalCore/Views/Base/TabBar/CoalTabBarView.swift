//
//  CoalTabBarView.swift
//
//
//  Created by M. Rizki Maulana on 12/11/24.
//

import SwiftUI

public struct CoalTabInfo {
  public let title: String
  public let icon: String?
  
  public init(title: String, icon: String?) {
    self.title = title
    self.icon = icon
  }
}

public protocol CoalTabInfoProviding {
  func coalTabInfo() -> CoalTabInfo
}

public struct CoalTabBarView: View {
  @ObservedObject var tabManager: CoalTabManager
  
  public init(tabManager: CoalTabManager) {
    self.tabManager = tabManager
  }
  
  public var body: some View {
    VStack {
      if tabManager.isTabBarVisible {
        TabView(selection: $tabManager.selectedTab) {
          ForEach(0..<tabManager.tabs.count, id: \.self) { index in
            tabItemView(for: tabManager.tabs[index].actionScreen)
              .tabItem {
                VStack {
                  if let iconName = tabManager.tabs[index].icon,
                     let uiImage = UIImage.loadImage(iconName) {
                    if let resizedImage = uiImage.resize(to: CGSize(width: 20, height: 20)) {
                      Image(uiImage: resizedImage)
                    }
                  }
                  Text(tabManager.tabs[index].title ?? "")
                }
              }
              .tag(index)
          }
        }
      }
    }
  }
  
  @ViewBuilder
  private func tabItemView(for screen: ViewScreenType) -> some View {
    switch screen {
    case .swiftui(let swiftUIView):
      AnyView(swiftUIView)
    case .uikit(let viewController):
      UIViewControllerWrapper(viewController: viewController)
    }
  }
}
