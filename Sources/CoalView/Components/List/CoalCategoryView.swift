//
//  CoalCategoryView.swift
//
//
//  Created by M. Rizki Maulana on 26/09/24.
//

import SwiftUI
import CoalModel
import CoalCore

public struct CoalCategoryView: View {
  let category: CategoryModel
  
  public init(category: CategoryModel) {
    self.category = category
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
        .font(.caption)
        .foregroundColor(.black)
    }
  }
  
  private var icon: some View {
    Group {
      if category.icon.isValidURL {
        AsyncImage(url: URL(string: category.icon)) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
        } placeholder: {
          RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.gray)
        }
      } else if UIImage(named: category.icon) != nil {
        Image(category.icon)
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.white)
      } else if UIImage(systemName: category.icon) != nil {
        Image(systemName: category.icon)
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .foregroundColor(.white)
      } else {
        RoundedRectangle(cornerRadius: 15)
          .foregroundColor(.gray)
      }
    }
  }
}
