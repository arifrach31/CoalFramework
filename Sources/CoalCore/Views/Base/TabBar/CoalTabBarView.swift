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
  @ObservedObject private var tabManager: CoalTabManager
  private let coalEnvironment: CoalEnvironment
  private let coalConfig: CoalConfig
  
  public init(
    tabManager: CoalTabManager,
    coalEnvironment: CoalEnvironment,
    coalConfig: CoalConfig
  ) {
    self.tabManager = tabManager
    self.coalEnvironment = coalEnvironment
    self.coalConfig = coalConfig
    
    configureTabBarAppearance()
  }
  
  public var body: some View {
    VStack {
      if isTabBarVisible {
        TabView(selection: $tabManager.selectedTab) {
          ForEach(tabManager.tabs.indices, id: \.self) { index in
            createTabItem(for: tabManager.tabs[index])
              .tag(index)
          }
        }
        .tint(activeTabColor)
      }
    }
  }
  
  private var isTabBarVisible: Bool {
    coalConfig.menuConfig?.isTabBarVisible ?? true
  }
  
  private var activeTabColor: Color {
    Color(coalConfig.menuConfig?.activeTabColor ?? .blue)
  }
  
  private func configureTabBarAppearance() {
    UITabBar.appearance().unselectedItemTintColor = coalConfig.menuConfig?.normalTabColor ?? .gray
  }
  
  @ViewBuilder
  private func createTabItem(for tab: MenuTabItem) -> some View {
    tabItemView(for: tab.viewScreen)
      .tabItem {
        VStack {
          if let iconName = tab.icon,
             let uiImage = UIImage.loadImage(iconName) {
            Image(uiImage: uiImage.resize(to: CGSize(width: 20, height: 20))!)
          }
          Text(tab.title ?? "")
        }
      }
  }
  
  @ViewBuilder
  private func tabItemView(for screen: ViewScreenType) -> some View {
    switch screen {
    case .swiftui(let swiftUIView):
      AnyView(
        swiftUIView
          .environmentObject(coalEnvironment)
          .environmentObject(coalConfig)
      )
    case .uikit(let viewController):
      UIViewControllerWrapper(viewController: viewController)
    }
  }
}
