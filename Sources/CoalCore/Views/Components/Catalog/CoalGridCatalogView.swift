//
//  CoalGridCatalogView.swift
//
//
//  Created by M. Rizki Maulana on 10/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalGridCatalogView: View {
  public let catalog: [ProductListModel]
  public var layoutType: LayoutDirection
  public var gridRows: Int
  public var imgSize: CGFloat
  public var cardSize: CGFloat
  public var title: String
  public var actionTitle: String
  public var actionClicked: () -> Void
  public var itemClicked: (ProductListModel) -> Void
  
  public init(
    catalog: [ProductListModel],
    layoutType: LayoutDirection,
    gridRows: Int,
    imgSize: CGFloat = 120,
    cardSize: CGFloat = 240,
    title: String,
    actionTitle: String = "See All",
    actionClicked: @escaping () -> Void = {},
    itemClicked: @escaping (ProductListModel) -> Void = { _ in }
  ) {
    self.catalog = catalog
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.imgSize = imgSize
    self.cardSize = cardSize
    self.title = title
    self.actionTitle = actionTitle
    self.actionClicked = actionClicked
    self.itemClicked = itemClicked
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if !title.isEmpty {
        headerSection
      }
      gridView
    }
    .padding(.bottom, 20)
  }
  
  private var headerSection: some View {
    HStack {
      Text(title)
        .lgnBodyLargeBold()
      
      Spacer()
      
      AnchorText(title: actionTitle, tintColor: Color.LGNTheme.tertiary500) {
        if actionClicked() != {}() {
          actionClicked()
        }
      }.variant(size: .small)
    }
    .padding(EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20))
  }
  
  private var gridView: some View {
    CoalGridView(layoutType: layoutType, gridRows: gridRows) {
      ForEach(catalog) { catalog in
        CoalCatalogView(
          catalog: catalog,
          layout: layoutType,
          itemClicked: itemClicked,
          imgSize: imgSize,
          cardSize: cardSize
        )
      }
    }
  }
}
