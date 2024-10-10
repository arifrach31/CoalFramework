//
//  CoalGridCategoryView.swift
//
//
//  Created by M. Rizki Maulana on 10/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalGridCategoryView: View {
  public let categories: [CategoryModel]
  public var layoutType: LayoutDirection
  public var gridRows: Int
  public var iconSize: CGFloat
  public var cardSize: CGFloat
  public var title: String
  public var actionTitle: String
  public var didSelectSeeAll: () -> Void
  public var didSelectItem: (CategoryModel) -> Void
  
  public init(
    categories: [CategoryModel],
    layoutType: LayoutDirection,
    gridRows: Int,
    title: String,
    actionTitle: String = CoalString.seeAll,
    iconSize: CGFloat = 30,
    cardSize: CGFloat = 60,
    didSelectSeeAll: @escaping () -> Void = {},
    didSelectItem: @escaping (CategoryModel) -> Void = { _ in }
  ) {
    self.categories = categories
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.title = title
    self.actionTitle = actionTitle
    self.iconSize = iconSize
    self.cardSize = cardSize
    self.didSelectSeeAll = didSelectSeeAll
    self.didSelectItem = didSelectItem
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if !title.isEmpty {
        headerSection
      }
      gridView
    }
    .padding(.bottom, 20)
    .background(Color(.systemGray6))
  }
  
  private var headerSection: some View {
    HStack {
      Text(title)
        .lgnBodyLargeBold()
      
      Spacer()
      
      AnchorText(title: actionTitle, tintColor: Color.LGNTheme.tertiary500) {
        if didSelectSeeAll() != {}() {
          didSelectSeeAll()
        }
      }.variant(size: .small)
    }
    .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
    .background(Color(.systemGray6))
  }
  
  private var gridView: some View {
    CoalGridView(layoutType: layoutType, gridRows: gridRows) {
      ForEach(categories) { category in
        CoalCategoryView(
          category: category,
          didSelectItem: didSelectItem,
          iconSize: iconSize,
          cardSize: cardSize
        )
      }
    }
  }
}
