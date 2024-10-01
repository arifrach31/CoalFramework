//
//  CoalGridView.swift
//
//
//  Created by M. Rizki Maulana on 30/09/24.
//

import SwiftUI
import CoalModel

public enum LayoutDirection {
  case horizontal
  case vertical
}

public struct CoalGridView: View {
  let category: [CategoryModel]?
  let catalog: [ProductListModel]?
  var layoutType: LayoutDirection
  var horizontalRows: Int = 0
  var verticalRows: Int = 0
  
  var columns: [GridItem] {
    switch layoutType {
    case .horizontal:
      return Array(repeating: GridItem(.fixed(100)), count: horizontalRows)
    case .vertical:
      return Array(repeating: GridItem(.flexible()), count: verticalRows)
    }
  }
  
  public init(category: [CategoryModel]? = nil, catalog: [ProductListModel]? = nil, layoutType: LayoutDirection, horizontalRows: Int, verticalRows: Int) {
    self.category = category
    self.catalog = catalog
    self.layoutType = layoutType
    self.horizontalRows = horizontalRows
    self.verticalRows = verticalRows
  }
  
  public var body: some View {
    scrollView
  }
  
  public var scrollView: some View {
    Group {
      ScrollView(layoutType == .horizontal ? .horizontal : .vertical, showsIndicators: false) {
        if layoutType == .horizontal {
          if let category = category {
            LazyHGrid(rows: columns, spacing: 16) {
              ForEach(category) { category in
                CoalCategoryView(category: category)
              }
            }
            .padding([.leading, .trailing], 20)
          } else if let catalog = catalog {
            if catalog.count == 1 {
              CoalCatalogView(catalog: catalog[0], isSingleItem: true)
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 16)
            } else {
              LazyHGrid(rows: columns, spacing: 16) {
                ForEach(catalog) { catalog in
                  CoalCatalogView(catalog: catalog, isSingleItem: false)
                }
              }
              .padding([.leading, .trailing], 20)
            }
          }
        } else {
          if let category = category {
            LazyVGrid(columns: columns, spacing: 16) {
              ForEach(category) { category in
                CoalCategoryView(category: category)
              }
            }
            .padding([.leading, .trailing], 20)
          } else if let catalog = catalog {
            if catalog.count == 1 {
              CoalCatalogView(catalog: catalog[0], isSingleItem: true)
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 16)
            } else {
              LazyVGrid(columns: columns, spacing: 16) {
                ForEach(catalog) { catalog in
                  CoalCatalogView(catalog: catalog, isSingleItem: false)
                }
              }
              .padding([.leading, .trailing], 20)
            }
          }
        }
      }
    }
  }
}
