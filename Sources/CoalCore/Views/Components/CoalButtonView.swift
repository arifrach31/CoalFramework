//
//  CoalButtonView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalButtonView: View {
  public let field: ConfigField
  public var isDisabled: Bool? = nil
  public var action: () -> Void
  
  public init(field: ConfigField, isDisabled: Bool? = nil, action: @escaping () -> Void = {}) {
    self.field = field
    self.isDisabled = isDisabled
    self.action = action
  }
  
  public var body: some View {
    LGNSolidButton(title: field.label ?? "BUTTON", defaultBtnColor: Color.redButton) {
      action()
    }
    .disableInteraction(isDisabled == true)
    .variant(size: .medium, responsive: true)
    .padding(.top, 10)
  }
}
