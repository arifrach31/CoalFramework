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
  private var dragable: Bool? = false
  private let content: Content
  
  public init(
    isShowing: Binding<Bool> = .constant(true),
    dragable: Bool? = false,
    @ViewBuilder content: () -> Content
  ) {
    self._isShowing = isShowing
    self.content = content()
    self.dragable = dragable
  }
  
  public var body: some View {
    LGNBottomSheet(
      isShowing: $isShowing,
      dragable: dragable ?? false
    ) {
      VStack(
        alignment: .leading,
        spacing: 5
      ) {
        content
          .padding(.horizontal, 20)
      }
    }
  }
}
