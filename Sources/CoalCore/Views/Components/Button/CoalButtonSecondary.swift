//
//  CoalButtonSecondary.swift
//
//
//  Created by M. Rizki Maulana on 23/10/24.
//

import SwiftUI
import ThemeLGN
import LegionUI

public struct CoalButtonSecondary: View {
  private let field: ConfigField
  private var action: () -> Void
  
  public init(
    field: ConfigField,
    action: @escaping () -> Void = {}
  ) {
    self.field = field
    self.action = action
  }
  
  public var body: some View {
    LGNOutlineButton(
      title: field.titleVerification,
      leftImage: field.iconVerification,
      tintBtnColor: Color.blackText,
      tintPressedBtnColor: LGNColor.tertiary700,
      pressedBtnColor: .white,
      cornerRadius: 24,
      borderColor: LGNColor.tertiary300
    ) {
      action()
    }
    .variant(size: .medium, responsive: true)
  }
}
