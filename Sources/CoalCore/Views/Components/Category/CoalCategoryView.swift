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
  private let didSelectItem: (CategoryModel) -> Void
  private let iconSize: CGFloat
  private let cardSize: CGFloat
  
  public init(
    category: CategoryModel,
    didSelectItem: @escaping (CategoryModel) -> Void = {_ in},
    iconSize: CGFloat = 30,
    cardSize: CGFloat = 60
  ) {
    self.category = category
    self.didSelectItem = didSelectItem
    self.iconSize = iconSize
    self.cardSize = cardSize
  }
  
  public var body: some View {
    VStack(spacing: 8) {
      categoryIcon
      categoryTitle
    }
    .onTapGesture {
      didSelectItem(category)
    }
  }
  
  private var categoryIcon: some View {
    ZStack {
      Color(hex: category.background)
        .frame(width: cardSize, height: cardSize)
        .cornerRadius(15)
      
      CoalImageView(
        imageURL: category.icon,
        cornerRadius: 15,
        width: iconSize,
        height: iconSize
      )
    }
  }
  
  private var categoryTitle: some View {
    Text(category.title)
      .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
  }
}
