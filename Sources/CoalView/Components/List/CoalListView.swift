//
//  CoalListView.swift
//
//
//  Created by M. Rizki Maulana on 26/09/24.
//

import SwiftUI
import CoalModel
import CoalCore
import LegionUI
import ThemeLGN

public struct CoalListView: View {
  let category: [CategoryModel]?
  let catalog: [ProductListModel]?
  let layoutType: LayoutDirection
  let horizontalRows: Int
  let verticalRows: Int
  
  public init(category: [CategoryModel]? = nil, catalog: [ProductListModel]? = nil, layoutType: LayoutDirection, horizontalRows: Int = 0, verticalRows: Int = 0) {
    self.category = category
    self.catalog = catalog
    self.layoutType = layoutType
    self.horizontalRows = horizontalRows
    self.verticalRows = verticalRows
  }
  
  public var body: some View {
    isGridView
  }
  
  public var isGridView: some View {
    Group {
      if let category = category {
        VStack(alignment: .leading, spacing: 20) {
          HStack {
            Text(CoalString.category)
              .lgnBodyLargeBold()
            
            Spacer()
            
            Text(CoalString.seeAll)
              .lgnCaptionLargeSemiBold(color: LGNColor.tertiary500)
          }
          .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
          
          CoalGridView(category: category, layoutType: layoutType, horizontalRows: horizontalRows, verticalRows: verticalRows)
        }
        .padding(.vertical, 16)
        .background(Color(.systemGray6))
      } else if let catalog = catalog {
        VStack(alignment: .leading, spacing: 20) {
          HStack {
            Text(CoalString.productList)
              .lgnBodyLargeBold()
            
            Spacer()
            
            Text(CoalString.seeAll)
              .lgnCaptionLargeSemiBold(color: LGNColor.tertiary500)
          }
          .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
          
          CoalGridView(catalog: catalog, layoutType: layoutType, horizontalRows: horizontalRows, verticalRows: verticalRows)
        }
        .padding(.vertical, 16)
      } else {
        RoundedRectangle(cornerRadius: 15)
          .foregroundColor(.gray)
      }
    }
  }
}
