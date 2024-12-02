//
//  CoalCardView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public struct CoalCardView: View {
  @Binding private var currentIndex: Int
  private let card: CarouselModel
  private let geometry: GeometryProxy
  private let cardHeight: CGFloat
  private let index: Int
  private let didSelectItem: (() -> Void)?
  
  private var cardWidth: CGFloat {
    geometry.size.width * 0.97
  }
  
  private var cardOffset: CGFloat {
    let cardWidthFactor = geometry.size.width * 0.8
    let baseOffset = (geometry.size.width - cardWidthFactor) / 0.75
    return CGFloat(index - currentIndex) * baseOffset
  }
  
  public init(
    card: CarouselModel,
    currentIndex: Binding<Int>,
    geometry: GeometryProxy,
    cardHeight: CGFloat = 188,
    index: Int,
    didSelectItem: (() -> Void)? = nil
  ) {
    self.card = card
    self._currentIndex = currentIndex
    self.geometry = geometry
    self.cardHeight = cardHeight
    self.index = index
    self.didSelectItem = didSelectItem
  }
  
  public var body: some View {
    ZStack {
      cardImage
        .padding(.all, 16)
    }
    .frame(width: cardWidth, height: cardHeight)
    .offset(x: cardOffset)
    .onTapGesture {
      didSelectItem?()
    }
  }
  
  private var cardImage: some View {
    CoalImageView(
      imageURL: card.image,
      cornerRadius: 16,
      width: cardWidth,
      height: cardHeight
    )
  }
}
