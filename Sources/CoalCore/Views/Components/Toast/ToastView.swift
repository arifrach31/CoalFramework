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
  @Binding private var isVisible: Bool
  private var title: String?
  private var subTitle: String?
  private var isError: Bool
  private var onDismiss: (() -> Void)?
  
  public init(
    isVisible: Binding<Bool>,
    title: String? = nil,
    subTitle: String? = nil,
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
    if isVisible {
      ToastContentView(
        title: title,
        subTitle: subTitle,
        isError: isError,
        onDismiss: onDismiss
      )
      .transition(.move(edge: .top))
    }
  }
}

private struct ToastContentView: View {
  public var title: String?
  public var subTitle: String?
  public var isError: Bool
  public var onDismiss: (() -> Void)?
  
  var body: some View {
    VStack {
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
    .padding(.top, 16)
    .padding(.horizontal, 16)
  }
}
