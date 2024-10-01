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
  let categories: [CategoryModel]
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
  
  public init(categories: [CategoryModel], layoutType: LayoutDirection, horizontalRows: Int, verticalRows: Int) {
    self.categories = categories
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
          LazyHGrid(rows: columns, spacing: 16) {
            ForEach(categories) { category in
              CoalCategoryView(category: category)
            }
          }
          .padding([.leading, .trailing], 20)
        } else {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(categories) { category in
              CoalCategoryView(category: category)
            }
          }
          .padding([.leading, .trailing], 20)
        }
      }
    }
  }
}
