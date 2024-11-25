//
//  CoalCarouselView.swift
//
//
//  Created by ArifRachman on 19/09/24.
//

import SwiftUI

public struct CoalCarouselView: View {
  @State private var currentIndex: Int = 0
  public let cards: [CarouselModel]?
  public let cardHeight: CGFloat?
  public let didSelectItem: (() -> Void)?
  
  public init(cards: [CarouselModel]? = nil,
              cardHeight: CGFloat? = 188,
              didSelectItem: (() -> Void)? = nil) {
    self.cards = cards
    self.cardHeight = cardHeight
    self.didSelectItem = didSelectItem
  }
  
  public var body: some View {
    GeometryReader { proxy in
      let actualGeometry = proxy
      VStack {
        if let cards = cards, !cards.isEmpty {
          ZStack {
            ForEach(cards.indices, id: \.self) { index in
              CoalCardView(
                card: cards[index],
                currentIndex: $currentIndex,
                geometry: actualGeometry,
                cardHeight: cardHeight ?? 0,
                index: index,
                didSelectItem: didSelectItem
              )
              .offset(x: CGFloat(index - currentIndex) * (actualGeometry.size.width * 0.72))
            }
          }
          .gesture(
            DragGesture()
              .onEnded { value in
                handleDragGesture(value: value, geometry: actualGeometry)
              }
          )
          PageControl(
            index: $currentIndex,
            maxIndex: cards.count > 1 ? (cards.count - 1) : 0
          )
          .padding(.top, -35)
        }
      }
    }
    .padding(.horizontal, 16)
    .frame(minHeight: 150, maxHeight: 190)
    .padding(.bottom, 50)
  }
  
  private func handleDragGesture(value: DragGesture.Value, geometry: GeometryProxy) {
    guard let cards = cards, !cards.isEmpty else { return }
    
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
