//
//  ToastView.swift
//
//
//  Created by ArifRachman on 23/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct ToastView: View {
  @Binding var isVisible: Bool
  var title: String
  var subTitle: String
  var isError: Bool
  
  public init(isVisible: Binding<Bool>, title: String, subTitle: String, isError: Bool = false) {
    self._isVisible = isVisible
    self.title = title
    self.subTitle = subTitle
    self.isError = isError
  }
  
  public var body: some View {
    VStack {
      if isVisible {
        Alert(
          title: title,
          subtitle: subTitle,
          action: ""
        )
        .theme(variant: isError ? .error : .success)
      }
      Spacer()
    }
    .padding(.top, -32)
    .padding(.horizontal, 16)
  }
}
