//
//  CoalCarouselView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI
import CoalModel

public struct CoalCarouselView: View {
  @Binding var currentIndex: Int
  let cards: [CarouselModel]
  let geometry: GeometryProxy
  
  public init(currentIndex: Binding<Int>, cards: [CarouselModel], geometry: GeometryProxy) {
    self._currentIndex = currentIndex
    self.cards = cards
    self.geometry = geometry
  }
  
  public var body: some View {
    VStack {
      ZStack {
        ForEach(cards) { card in
          CoalCardView(card: card, currentIndex: $currentIndex, geometry: geometry) {
            Text(card.page.rawValue)
              .foregroundColor(.white)
          }
          .offset(x: CGFloat(card.id - currentIndex) * (geometry.size.width * 0.72))
        }
      }
      .gesture(
        DragGesture()
          .onEnded { value in
            handleDragGesture(value: value, geometry: geometry)
          }
      )
      
      PageControl(index: $currentIndex, maxIndex: cards.count > 1 ? (cards.count - 1) : 0)
        .padding(.top, -30)
    }
  }
  
  private func handleDragGesture(value: DragGesture.Value, geometry: GeometryProxy) {
    let cardWidth = geometry.size.width * 0.2
    let offset = value.translation.width / cardWidth
    
    withAnimation(.spring()) {
      if value.translation.width < -offset {
        currentIndex = min(currentIndex + 1, cards.count - 1)
      } else if value.translation.width > offset {
        currentIndex = max(currentIndex - 1, 0)
      }
    }
  }
}

struct PageControl: View {
  @Binding var index: Int
  let maxIndex: Int
  var body: some View {
    HStack(spacing: 8) {
      ForEach(0...maxIndex, id: \.self) { idx in
        if idx == self.index {
          Capsule()
            .fill(.red.opacity(1))
            .frame(width: 15, height: 4)
        } else {
          Circle()
            .fill(.white.opacity(1))
            .frame(width: 4, height: 4)
        }
      }
    }
    .background(Capsule().fill(Color.white.opacity(1)))
    .padding(.horizontal, 16)
  }
}
