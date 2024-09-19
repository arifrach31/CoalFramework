//
//  CoalCardView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI
import CoalModel

public struct CoalCardView<Content: View>: View {
  let card: CarouselModel
  let content: Content
  let geometry: GeometryProxy
  @Binding var currentIndex: Int
  
  public init(card: CarouselModel, currentIndex: Binding<Int>, geometry: GeometryProxy, @ViewBuilder content: () -> Content) {
    self.card = card
    self._currentIndex = currentIndex
    self.geometry = geometry
    self.content = content()
  }
  
  public var body: some View {
    let cardWidth = geometry.size.width * 0.8
    let cardHeight: CGFloat = 136
    let offset = (geometry.size.width - cardWidth) / 2
    
    return ZStack {
      RoundedRectangle(cornerRadius: 16)
        .foregroundColor(card.color)
        .background(
          RoundedRectangle(cornerRadius: 16)
            .stroke(.gray.opacity(0.16), lineWidth: 1)
        )
        .frame(width: cardWidth, height: cardHeight)
        .opacity(card.id <= currentIndex + 1 ? 1.0 : 0.0)
        .scaleEffect(card.id == currentIndex ? 1.0 : 0.9)
      
      content
        .padding(.all, 16)
    }
    .frame(width: cardWidth, height: cardHeight)
    .offset(x: CGFloat(card.id - currentIndex) * offset)
  }
}
