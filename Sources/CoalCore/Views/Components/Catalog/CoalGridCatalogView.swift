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
  private let catalog: [ProductListModel]?
  
  public init(catalog: [ProductListModel]? = nil) {
    self.catalog = catalog
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if catalog?.first?.title.isEmpty != nil {
        headerSection
      }
      if let catalog = catalog, !catalog.isEmpty {
        gridView(catalog: catalog)
      }
    }
    .padding(.bottom, 20)
  }
  
  private var headerSection: some View {
    HStack {
      Text(catalog?.first?.titleSection ?? "")
        .lgnBodyLargeBold()
      
      Spacer()
      
      AnchorText(
        title: catalog?.first?.actionTitleSection ?? "",
        tintColor: Color.LGNTheme.tertiary500
      ) {
        catalog?.first?.didSelectSeeAll()
      }
      .variant(size: .small)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
  }
    
  private func gridView(catalog: [ProductListModel]) -> some View {
    CoalGridView(
      layoutType: catalog.first?.layoutType ?? .horizontal,
      gridRows: catalog.first?.gridRows ?? 1
    ) {
      ForEach(catalog) { item in
        CoalCatalogView(catalog: item)
      }
    }
  }
}
