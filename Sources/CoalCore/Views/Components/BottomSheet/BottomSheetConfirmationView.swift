//
//  BottomSheetConfirmationView.swift
//
//
//  Created by ArifRachman on 06/11/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct BottomSheetConfirmationView: View {
  private let title: String
  private let description: String
  private let buttonTitle: String
  private let buttonAction: () -> Void
  
  public init(
    title: String,
    description: String,
    buttonTitle: String,
    buttonAction: @escaping () -> Void
  ) {
    self.title = title
    self.description = description
    self.buttonTitle = buttonTitle
    self.buttonAction = buttonAction
  }
  
  public var body: some View {
    VStack(spacing: 10) {
      Text(title)
        .font(.headline)
        .multilineTextAlignment(.center)
      
      Text(description)
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .padding(.bottom, 20)
      
      actionButton
    }
    .padding(.top, 20)
    .padding(.horizontal, 20)
  }
  
  private var actionButton: some View {
    LGNSolidButton(
      title: buttonTitle,
      tintBtnColor: .white,
      defaultBtnColor: .redButton,
      cornerRadius: 24
    ) {
      buttonAction()
    }
  }
}
