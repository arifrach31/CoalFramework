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
  
  public init(
    cards: [CarouselModel]? = nil,
    cardHeight: CGFloat? = 188,
    didSelectItem: (() -> Void)? = nil
  ) {
    self.cards = cards
    self.cardHeight = cardHeight
    self.didSelectItem = didSelectItem
  }
  
  public var body: some View {
    GeometryReader { proxy in
      VStack {
        if let cards = cards, !cards.isEmpty {
          carouselView(cards: cards, geometry: proxy)
          pageControl(maxIndex: cards.count - 1)
            .padding(.top, -35)
        }
      }
    }
    .padding(.horizontal, 16)
    .frame(minHeight: 150, maxHeight: cardHeight ?? 190)
    .padding(.bottom, 50)
  }
  
  @ViewBuilder
  private func carouselView(cards: [CarouselModel], geometry: GeometryProxy) -> some View {
    ZStack {
      ForEach(cards.indices, id: \.self) { index in
        CoalCardView(
          card: cards[index],
          currentIndex: $currentIndex,
          geometry: geometry,
          cardHeight: cardHeight ?? 188,
          index: index,
          didSelectItem: didSelectItem
        )
        .offset(x: CGFloat(index - currentIndex) * (geometry.size.width * 0.72))
      }
    }
    .gesture(
      DragGesture()
        .onEnded { value in
          handleDragGesture(value: value, geometry: geometry, cardCount: cards.count)
        }
    )
  }
  
  private func pageControl(maxIndex: Int) -> some View {
    PageControl(
      index: $currentIndex,
      maxIndex: maxIndex
    )
  }
  
  private func handleDragGesture(value: DragGesture.Value, geometry: GeometryProxy, cardCount: Int) {
    let cardWidth = geometry.size.width * 0.2
    let offset = value.translation.width / cardWidth
    
    withAnimation(.spring()) {
      if value.translation.width < -offset {
        currentIndex = min(currentIndex + 1, cardCount - 1)
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
