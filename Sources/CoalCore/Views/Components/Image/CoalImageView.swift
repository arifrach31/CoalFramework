//
//  CoalImageView.swift
//
//
//  Created by ArifRachman on 04/10/24.
//

import SwiftUI

public struct CoalImageView: View {
  private let imageURL: String
  private let cornerRadius: CGFloat
  private let width: CGFloat?
  private let height: CGFloat?
  private let placeholderColor: Color
  
  public init(
    imageURL: String,
    cornerRadius: CGFloat = 16,
    width: CGFloat? = nil,
    height: CGFloat? = nil,
    placeholderColor: Color = .gray
  ) {
    self.imageURL = imageURL
    self.cornerRadius = cornerRadius
    self.width = width
    self.height = height
    self.placeholderColor = placeholderColor
  }
  
  public var body: some View {
    content
      .frame(width: width, height: height)
      .cornerRadius(cornerRadius)
      .clipped()
  }
  
  @ViewBuilder
  private var content: some View {
    if let url = URL(string: imageURL), imageURL.isValidURL {
      asyncImageView(url: url)
    } else if let image = UIImage(named: imageURL) {
      staticImageView(image: Image(uiImage: image))
    } else if let systemImage = UIImage(systemName: imageURL) {
      systemImageView(image: Image(systemName: imageURL))
    } else {
      placeholderView
    }
  }
  
  private func asyncImageView(url: URL) -> some View {
    AsyncImage(url: url) { phase in
      switch phase {
      case .success(let image):
        image
          .resizable()
          .scaledToFill()
      case .failure(_), .empty:
        placeholderView
      @unknown default:
        placeholderView
      }
    }
  }
  
  private func staticImageView(image: Image) -> some View {
    image
      .resizable()
      .scaledToFill()
  }
  
  private func systemImageView(image: Image) -> some View {
    image
      .resizable()
      .scaledToFit()
      .foregroundColor(.white)
  }
  
  private var placeholderView: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .fill(placeholderColor)
  }
}
