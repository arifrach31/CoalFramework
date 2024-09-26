//
//  CoalListView.swift
//
//
//  Created by M. Rizki Maulana on 26/09/24.
//

import SwiftUI
import CoalModel
import CoalCore

public struct CoalListView: View {
  let category: [CategoryModel]
  
  public init(category: [CategoryModel]) {
    self.category = category
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        Text(CoalString.category)
          .font(.headline)
          .foregroundColor(.black)
        
        Spacer()
        
        Text(CoalString.seeAll)
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      .padding(EdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20))
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 24) {
          ForEach(Array(category.enumerated()), id: \.offset) { _, category in
            CoalCategoryView(category: category)
          }
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 16, trailing: 20))
      }
    }
    .padding(.vertical, 16)
    .background(Color(.systemGray6))
  }
}
