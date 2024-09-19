//
//  CoalButtonView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import CoalModel
import LegionUI
import ThemeLGN

public struct CoalButtonView: View {
  public let field: ConfigField
  public var isDisabled: Bool? = nil
  
  public init(field: ConfigField, isDisabled: Bool? = nil) {
    self.field = field
    self.isDisabled = isDisabled
  }
  
  public var body: some View {
    LGNSolidButton(title: field.label ?? "BUTTON", defaultBtnColor: Color.redButton)
      .disableInteraction(isDisabled == true)
      .variant(size: .medium, responsive: true)
      .padding(.top, 10)
  }
}
