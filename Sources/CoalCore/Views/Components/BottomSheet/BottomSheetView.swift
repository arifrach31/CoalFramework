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
  let content: Content
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        content
          .padding(.horizontal, 20)
      }
    }
  }
}
