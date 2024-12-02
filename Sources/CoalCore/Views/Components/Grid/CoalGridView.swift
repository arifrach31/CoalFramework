//
//  CoalGridView.swift
//
//
//  Created by M. Rizki Maulana on 30/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public enum LayoutDirectionType {
  case horizontal
  case vertical
}

public struct CoalGridView<Content: View>: View {
  private let layoutType: LayoutDirectionType
  private let gridRows: Int
  private let spacing: CGFloat
  private let content: Content
  
  private var columns: [GridItem] {
    Array(repeating: GridItem(.flexible(), spacing: spacing), count: gridRows)
  }
  
  public init(
    layoutType: LayoutDirectionType,
    gridRows: Int,
    spacing: CGFloat = 16,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.layoutType = layoutType
    self.gridRows = gridRows
    self.spacing = spacing
    self.content = content()
  }
  
  public var body: some View {
    ScrollView(scrollAxis, showsIndicators: false) {
      gridView
        .padding(.horizontal, 20)
    }
  }
  
  @ViewBuilder
  private var gridView: some View {
    switch layoutType {
    case .horizontal:
      LazyHGrid(rows: columns, spacing: spacing) {
        content
      }
    case .vertical:
      LazyVGrid(columns: columns, spacing: spacing) {
        content
      }
    }
  }
  
  private var scrollAxis: Axis.Set {
    layoutType == .horizontal ? .horizontal : .vertical
  }
}
