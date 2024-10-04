//
//  CoalImageView.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import SwiftUI

public struct CoalImageView: View {
  let imageURL: String
  let cornerRadius: CGFloat
  let width: CGFloat?
  let height: CGFloat?
  let placeholderColor: Color
  
  public init(imageURL: String,
              cornerRadius: CGFloat = 16,
              width: CGFloat? = nil,
              height: CGFloat? = nil,
              placeholderColor: Color = .gray) {
    self.imageURL = imageURL
    self.cornerRadius = cornerRadius
    self.width = width
    self.height = height
    self.placeholderColor = placeholderColor
  }
  
  public var body: some View {
    Group {
      if let url = URL(string: imageURL), imageURL.isValidURL {
        AsyncImage(url: url) { image in
          image
            .resizable()
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(cornerRadius)
        } placeholder: {
          defaultPlaceholder(width: width, height: height, color: placeholderColor)
        }
      } else if UIImage(named: imageURL) != nil {
        Image(imageURL)
          .resizable()
          .frame(width: width, height: height)
          .clipped()
          .cornerRadius(cornerRadius)
      } else if UIImage(systemName: imageURL) != nil {
        Image(systemName: imageURL)
          .resizable()
          .scaledToFit()
          .frame(width: width, height: height)
          .foregroundColor(.white)
      } else {
        defaultPlaceholder(width: width, height: height, color: placeholderColor)
      }
    }
  }
  
  public func defaultPlaceholder(width: CGFloat?, height: CGFloat?, color: Color) -> some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .foregroundColor(color)
      .frame(width: width, height: height)
  }
}
