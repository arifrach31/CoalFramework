//
//  CoalCarouselView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public struct CoalCarouselView: View {
  @Binding public var currentIndex: Int
  public let cards: [CarouselModel]
  public let geometry: GeometryProxy?
  public let cardHeight: CGFloat
  public let action: () -> Void
  
  public init(currentIndex: Binding<Int> = .constant(0), 
              cards: [CarouselModel],
              geometry: GeometryProxy? = nil,
              cardHeight: CGFloat = 188,
              action: @escaping () -> Void = {}) {
    self._currentIndex = currentIndex
    self.cards = cards
    self.geometry = geometry
    self.cardHeight = cardHeight
    self.action = action
  }
  
  public var body: some View {
    GeometryReader { proxy in
      let actualGeometry = geometry ?? proxy
      VStack {
        ZStack {
          ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
            CoalCardView(card: card, currentIndex: $currentIndex, geometry: actualGeometry, cardHeight: cardHeight, index: index, action: action) {
            }
            .offset(x: CGFloat(index - currentIndex) * (actualGeometry.size.width * 0.72))
          }
        }
        .gesture(
          DragGesture()
            .onEnded { value in
              handleDragGesture(value: value, geometry: actualGeometry)
            }
        )
        PageControl(index: $currentIndex, maxIndex: cards.count > 1 ? (cards.count - 1) : 0)
          .padding(.top, -35)
        
      }
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
