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
  
  public init(
    title: String,
    icon: String?
  ) {
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
    tabBarView
  }
  
  @ViewBuilder
  private var tabBarView: some View {
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
  
  private func createTabItem(for tab: MenuTabItem) -> some View {
    tabItemView(for: tab.viewScreen)
      .tabItem {
        TabItemContent(iconName: tab.icon, title: tab.title)
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

private extension CoalTabBarView {
  var isTabBarVisible: Bool {
    coalConfig.menuConfig?.isTabBarVisible ?? true
  }
  
  var activeTabColor: Color {
    Color(coalConfig.menuConfig?.activeTabColor ?? .blue)
  }
  
  func configureTabBarAppearance() {
    UITabBar.appearance().unselectedItemTintColor = coalConfig.menuConfig?.normalTabColor ?? .gray
    UITabBar.appearance().backgroundColor = coalConfig.menuConfig?.backgroundTabColor ?? .yellow
  }
}

private struct TabItemContent: View {
  let iconName: String?
  let title: String?
  
  var body: some View {
    VStack {
      if let iconName = iconName {
        Image(uiImage: UIImage.loadImage(iconName)?.resize(to: CGSize(width: 20, height: 20)) ?? UIImage())
          .resizable()
          .frame(width: 20, height: 20)
      }
      Text(title ?? "")
    }
  }
}
