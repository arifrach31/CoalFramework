//
//  AnchorText.swift
//
//
//  Created by M. Rizki Maulana on 05/11/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public extension AnchorText {
  func underlined() -> some View {
    self.overlay(
      Rectangle()
        .frame(height: 1)
        .offset(y: 1)
        .foregroundColor(Color.LGNTheme.secondary500),
      alignment: .bottom
    )
  }
}
