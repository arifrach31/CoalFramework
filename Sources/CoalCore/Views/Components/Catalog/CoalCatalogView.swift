//
//  CoalCatalogView.swift
//
//
//  Created by M. Rizki Maulana on 01/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalCatalogView: View {
  private let catalog: ProductListModel
  
  public init(catalog: ProductListModel) {
    self.catalog = catalog
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      thumbnailSection
      titleSection
      descriptionSection
    }
    .frame(width: catalog.layoutType == .horizontal ? catalog.cardSize : nil)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(15)
    .shadow(radius: 4)
    .onTapGesture {
      catalog.didSelectItem(catalog)
    }
  }
  
  private var thumbnailSection: some View {
    ZStack(alignment: .topLeading) {
      imgThumbnail
      categoryChip
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
    CoalImageView(
      imageURL: catalog.image,
      cornerRadius: 16,
      height: catalog.imgSize
    )
  }
  
  private var categoryChip: some View {
    Text(catalog.category)
      .lgnCaptionSmallRegular(color: .white)
      .padding(8)
      .background(Color.black.opacity(0.7))
      .cornerRadius(900)
      .padding(.leading, 16)
      .padding(.top, 16)
  }
}
