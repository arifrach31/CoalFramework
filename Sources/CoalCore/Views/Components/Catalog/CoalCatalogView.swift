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
  var layout: LayoutDirection
  var itemClicked: (ProductListModel) -> Void
  var imgSize: CGFloat
  var cardSize: CGFloat
  
  public init(catalog: ProductListModel, layout: LayoutDirection, itemClicked: @escaping (ProductListModel) -> Void = {_ in}, imgSize: CGFloat = 120, cardSize: CGFloat = 240) {
    self.catalog = catalog
    self.layout = layout
    self.itemClicked = itemClicked
    self.imgSize = imgSize
    self.cardSize = cardSize
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      thumbnailSection
      titleSection
      descriptionSection
    }
    .frame(width: layout == .horizontal ? cardSize : nil)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 4)
    .onTapGesture {
      if itemClicked(catalog) != {}() {
        itemClicked(catalog)
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
      .lineLimit(1)
  }
  
  private var descriptionSection: some View {
    Text(catalog.description)
      .lgnCaptionSmallRegular(color: LGNColor.tertiary500)
      .lineLimit(2)
      .padding(.horizontal, 8)
      .padding(.bottom, 8)
  }
  
  private var imgThumbnail: some View {
    CoalImageView(imageURL: catalog.image, cornerRadius: 16, height: imgSize)
  }
}
