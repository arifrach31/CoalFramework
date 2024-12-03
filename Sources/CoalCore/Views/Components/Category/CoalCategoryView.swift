//
//  CoalCategoryView.swift
//
//
//  Created by M. Rizki Maulana on 26/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalCategoryView: View {
  private let category: CategoryModel
  
  public init(category: CategoryModel) {
    self.category = category
  }
  
  public var body: some View {
    VStack(spacing: 8) {
      categoryIcon
      categoryTitle
    }
    .onTapGesture {
      category.didSelectItem(category)
    }
  }
  
  private var categoryIcon: some View {
    ZStack {
      Color(hex: category.background)
        .frame(width: category.cardSize, height: category.cardSize)
        .cornerRadius(15)
      
      CoalImageView(
        imageURL: category.icon,
        cornerRadius: 15,
        width: category.iconSize,
        height: category.iconSize
      )
    }
  }
  
  private var categoryTitle: some View {
    Text(category.title)
      .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
  }
}
