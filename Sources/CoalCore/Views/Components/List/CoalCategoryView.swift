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
  let action: () -> Void
  
  public init(category: CategoryModel, action: @escaping () -> Void = {}) {
    self.category = category
    self.action = action
  }
  
  public var body: some View {
    VStack(spacing: 8) {
      ZStack {
        Color(hex: category.background)
          .frame(width: 60, height: 60)
          .cornerRadius(15)
        
        icon
      }
      
      Text(category.title)
        .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
    }
    .onTapGesture {
      action()
    }
  }
  
  private var icon: some View {
    CoalImageView(imageURL: category.icon, cornerRadius: 15, width: 30, height: 30)
  }
}
