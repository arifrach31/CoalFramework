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
  private let categories: [CategoryModel]?
  
  public init(categories: [CategoryModel]? = nil) {
    self.categories = categories
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if categories?.first?.titleSection != nil {
        headerSection
      }
      if let categories = categories, !categories.isEmpty {
        gridView(categories: categories)
      }
    }
    .padding(.bottom, 20)
    .background(Color(.systemGray6))
  }
  
  private var headerSection: some View {
    HStack {
      Text(categories?.first?.titleSection ?? "")
        .lgnBodyLargeBold()
      
      Spacer()
      
      AnchorText(
        title: categories?.first?.actionTitleSection ?? "",
        tintColor: Color.LGNTheme.tertiary500
      ) {
        categories?.first?.didSelectSeeAll()
      }
      .variant(size: .small)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
    .background(Color(.systemGray6))
  }
  
  private func gridView(categories: [CategoryModel]) -> some View {
    CoalGridView(
      layoutType: categories.first?.layoutType ?? .horizontal,
      gridRows: categories.first?.gridRows ?? 1
    ) {
      ForEach(categories) { category in
        CoalCategoryView(category: category)
      }
    }
  }
}
