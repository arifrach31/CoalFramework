//
//  CoalCatalogView.swift
//
//
//  Created by M. Rizki Maulana on 01/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

struct CoalCatalogView: View {
  let catalog: ProductListModel
  var isSingleItem: Bool
  var action: () -> Void
  
  public init(catalog: ProductListModel, isSingleItem: Bool, action: @escaping () -> Void = {}) {
    self.catalog = catalog
    self.isSingleItem = isSingleItem
    self.action = action
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      thumbnailSection
      titleSection
      descriptionSection
    }
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 4)
    .onTapGesture {
      if action() != {}() {
        action()
      }
    }
  }
  
  private var thumbnailSection: some View {
    ZStack(alignment: .topLeading) {
      imgThumbnail
      Text(catalog.category)
        .lgnCaptionSmallRegular(color: .white)
        .padding(8)
        .background(Color.black.opacity(0.7))
        .cornerRadius(4)
        .padding(.leading, 16) 
        .padding(.top, 16)
    }
  }
  
  private var titleSection: some View {
    Text(catalog.title)
      .lgnCaptionLargeBold(color: .black)
      .padding(.horizontal, 8)
  }
  
  private var descriptionSection: some View {
    Text(catalog.description)
      .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
      .lineLimit(2)
      .padding(.horizontal, 8)
      .padding(.bottom, 8)
  }
  
  private var imgThumbnail: some View {
    Group {
      if let url = URL(string: catalog.image), catalog.image.isValidURL {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .aspectRatio(contentMode: isSingleItem ? .fill : .fit)
            .frame(height: 120)
            .clipped()
            .cornerRadius(15)
        } placeholder: {
          placeholderThumbnail
        }
      } else if UIImage(named: catalog.image) != nil {
        Image(catalog.image)
          .resizable()
          .aspectRatio(contentMode: isSingleItem ? .fill : .fit)
          .frame(height: 120)
          .clipped()
          .cornerRadius(15)
          .padding(8)
      } else {
        placeholderThumbnail
      }
    }
  }
  
  private var placeholderThumbnail: some View {
    RoundedRectangle(cornerRadius: 15)
      .foregroundColor(.gray)
      .frame(height: 120)
  }
}
