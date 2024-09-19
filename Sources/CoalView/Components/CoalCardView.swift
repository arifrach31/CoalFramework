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
  
  public init(card: CarouselModel, currentIndex: Binding<Int>, geometry: GeometryProxy, cardHeight: CGFloat = 188, action: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
    self.card = card
    self._currentIndex = currentIndex
    self.geometry = geometry
    self.cardHeight = cardHeight
    self.action = action
    self.content = content()
  }
  
  public var body: some View {
    let cardWidth = geometry.size.width * 0.9
    let _ = (geometry.size.width - cardWidth) / 2
    let spacing: CGFloat = 8
    
    return Button(action: {
      action()
    }) {
      ZStack {
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
        
        RoundedRectangle(cornerRadius: 16)
          .stroke(.gray.opacity(0.16), lineWidth: 1)
          .frame(width: cardWidth, height: cardHeight)
          .opacity(card.id <= currentIndex + 1 ? 1.0 : 0.0)
          .scaleEffect(card.id == currentIndex ? 1.0 : 0.9)
        
        content
          .padding(.all, 16)
      }
      .frame(width: cardWidth, height: cardHeight)
      .offset(x: (CGFloat(card.id - currentIndex) * (cardWidth + spacing)) / 2)
    }
    .buttonStyle(PlainButtonStyle())
  }
}
