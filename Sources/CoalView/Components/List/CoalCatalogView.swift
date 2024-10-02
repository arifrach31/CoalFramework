//
//  CoalCatalogView.swift
//
//
//  Created by M. Rizki Maulana on 01/10/24.
//

import SwiftUI
import CoalModel
import CoalCore
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
    .padding()
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
        .padding(4)
        .background(Color.black.opacity(0.7))
        .cornerRadius(4)
        .padding(8)
    }
  }
  
  private var titleSection: some View {
    Text(catalog.title)
      .lgnCaptionLargeBold(color: .black)
  }
  
  private var descriptionSection: some View {
    Text(catalog.description)
      .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
      .lineLimit(2)
  }
  
  private var imgThumbnail: some View {
    Group {
      if catalog.image.isValidURL {
        AsyncImage(url: URL(string: catalog.image)) { image in
          image
            .resizable()
            .aspectRatio(contentMode: isSingleItem ? .fill : .fit)
            .frame(height: 120)
            .clipped()
            .cornerRadius(15)
        } placeholder: {
          RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.gray)
        }
      } else if UIImage(named: catalog.image) != nil {
        Image(catalog.image)
          .resizable()
          .aspectRatio(contentMode: isSingleItem ? .fill : .fit)
          .frame(height: 120)
          .clipped()
          .cornerRadius(15)
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
