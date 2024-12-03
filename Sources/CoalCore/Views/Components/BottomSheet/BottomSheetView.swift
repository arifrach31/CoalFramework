//
//  BottomSheetView.swift
//
//
//  Created by ArifRachman on 16/10/24.
//

import SwiftUI
import ThemeLGN
import LegionUI

public struct BottomSheetView<Content: View>: View {
  @Binding private var isShowing: Bool
  private let isDraggable: Bool
  private let isScrollView: Bool
  private let content: Content
  
  public init(
    isShowing: Binding<Bool> = .constant(true),
    isDraggable: Bool = false,
    isScrollView: Bool = false,
    @ViewBuilder content: () -> Content
  ) {
    self._isShowing = isShowing
    self.isDraggable = isDraggable
    self.isScrollView = isScrollView
    self.content = content()
  }
  
  public var body: some View {
    LGNBottomSheet(
      isShowing: $isShowing,
      dragable: isDraggable
    ) {
      contentView
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    if isScrollView {
      ScrollView(showsIndicators: false) {
        contentContainer
      }
    } else {
      contentContainer
    }
  }
  
  private var contentContainer: some View {
    VStack(alignment: .leading, spacing: 5) {
      content
        .padding(.horizontal, 20)
    }
  }
}
