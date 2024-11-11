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
  var title: String?
  var subTitle: String?
  var isError: Bool
  var onDismiss: (() -> Void)?
  
  public init(
    isVisible: Binding<Bool>,
    title: String? = "",
    subTitle: String? = "",
    isError: Bool = false,
    onDismiss: (() -> Void)? = nil
  ) {
    self._isVisible = isVisible
    self.title = title
    self.subTitle = subTitle
    self.isError = isError
    self.onDismiss = onDismiss
  }
  
  public var body: some View {
    VStack {
      if isVisible {
        Alert(
          title: title ?? "",
          subtitle: subTitle ?? "",
          action: ""
        )
        .theme(variant: isError ? .error : .success)
        .onDismissed {
          onDismiss?()
        }
      }
      Spacer()
    }
    .padding(.top, 16)
    .padding(.horizontal, 16)
  }
}
