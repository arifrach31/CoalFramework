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
  let category: CategoryModel
  let didSelectItem: (CategoryModel) -> Void
  var iconSize: CGFloat
  var cardSize: CGFloat
  
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
      ZStack {
        Color(hex: category.background)
          .frame(width: cardSize, height: cardSize)
          .cornerRadius(15)
        
        icon
      }
      
      Text(category.title)
        .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
    }
    .onTapGesture {
      if didSelectItem(category) != {}() {
        didSelectItem(category)
      }
    }
  }
  
  private var icon: some View {
    CoalImageView(imageURL: category.icon, cornerRadius: 15, width: iconSize, height: iconSize)
  }
}
