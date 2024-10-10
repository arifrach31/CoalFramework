//
//  CoalGridView.swift
//
//
//  Created by M. Rizki Maulana on 30/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public enum LayoutDirection {
  case horizontal
  case vertical
}

public struct CoalGridView<Content: View>: View {
  var layoutType: LayoutDirection
  var gridRows: Int
  var spacing: CGFloat
  var content: () -> Content
  
  private var columns: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridRows)
  }
  
  public init(
    layoutType: LayoutDirection,
    gridRows: Int,
    spacing: CGFloat = 16,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.spacing = spacing
    self.content = content
  }
  
  public var body: some View {
    ScrollView(layoutType == .horizontal ? .horizontal : .vertical, showsIndicators: false) {
      if case .horizontal = layoutType {
        LazyHGrid(rows: columns, spacing: spacing) {
          content()
        }
        .padding(.horizontal, 20)
      } else {
        LazyVGrid(columns: columns, spacing: spacing) {
          content()
        }
        .padding(.horizontal, 20)
      }
    }
  }
}
