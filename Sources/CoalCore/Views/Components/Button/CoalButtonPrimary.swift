//
//  CoalButtonPrimary.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalButtonPrimary: View {
  private let field: ConfigField
  private let isDisabled: Bool
  private let action: () -> Void
  
  public init(
    field: ConfigField,
    isDisabled: Bool = false,
    action: @escaping () -> Void = {}
  ) {
    self.field = field
    self.isDisabled = isDisabled
    self.action = action
  }
  
  public var body: some View {
    LGNSolidButton(
      title: buttonTitle,
      tintBtnColor: buttonTextColor,
      defaultBtnColor: buttonBackgroundColor,
      cornerRadius: 24
    ) {
      action()
    }
    .disableInteraction(isDisabled)
    .variant(size: .medium, responsive: true)
    .padding(.top, 10)
  }
  
  private var buttonTitle: String {
    field.label ?? ""
  }
  
  private var buttonTextColor: Color {
    Color(hex: field.labelColor ?? Color.white.toHex() ?? "")
  }
  
  private var buttonBackgroundColor: Color {
    Color(hex: field.backgroundColor ?? Color.redButton.toHex() ?? "")
  }
}
