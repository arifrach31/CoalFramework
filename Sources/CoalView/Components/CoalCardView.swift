//
//  CoalCardView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI
import CoalModel

public struct CoalCardView<Content: View>: View {
  @Binding var currentIndex: Int
  let card: CarouselModel
  let content: Content
  let geometry: GeometryProxy
  let cardHeight: CGFloat
  let action: () -> Void
  
  private var cardWidth: CGFloat {
    geometry.size.width * 0.97
  }
  
  private var cardOffset: CGFloat {
    let width = geometry.size.width * 0.8
    let baseOffset = (geometry.size.width - width) / 0.75
    return CGFloat(card.id - currentIndex) * baseOffset
  }
  
  public init(card: CarouselModel, currentIndex: Binding<Int>, geometry: GeometryProxy, cardHeight: CGFloat = 188, action: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
    self.card = card
    self._currentIndex = currentIndex
    self.geometry = geometry
    self.cardHeight = cardHeight
    self.action = action
    self.content = content()
  }
  
  public var body: some View {
    ZStack {
      cardBackground
      content
        .padding(.all, 16)
    }
    .frame(width: cardWidth, height: cardHeight)
    .offset(x: cardOffset)
    .onTapGesture {
      action()
    }
  }
  
  private var cardBackground: some View {
    Group {
      if let imageURL = URL(string: card.image) {
        AsyncImage(url: imageURL) { image in
          image
            .resizable()
            .scaledToFill()
            .clipped()
        } placeholder: {
          RoundedRectangle(cornerRadius: 16)
            .foregroundColor(card.color)
        }
      } else {
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(card.color)
      }
    }
  }
}
