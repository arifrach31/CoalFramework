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
  let category: [CategoryModel]
  let layoutType: LayoutDirection
  let horizontalRows: Int
  let verticalRows: Int
  
  public init(category: [CategoryModel], layoutType: LayoutDirection, horizontalRows: Int = 0, verticalRows: Int = 0) {
    self.category = category
    self.layoutType = layoutType
    self.horizontalRows = horizontalRows
    self.verticalRows = verticalRows
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Text(CoalString.category)
          .lgnBodyLargeBold()
        
        Spacer()
        
        Text(CoalString.seeAll)
          .lgnCaptionLargeSemiBold(color: LGNColor.tertiary500)
      }
      .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
      
      CoalGridView(categories: category, layoutType: layoutType, horizontalRows: horizontalRows, verticalRows: verticalRows)
    }
    .padding(.vertical, 16)
    .background(Color(.systemGray6))
  }
}
