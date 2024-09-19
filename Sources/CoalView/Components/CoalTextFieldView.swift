//
//  CoalTextFieldView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import CoalCore
import CoalModel
import LegionUI
import ThemeLGN

public struct CoalTextFieldView: View {
  public let field: ConfigField
  @Binding public var value: String
  @Binding public var isSecure: Bool
  
  public init(field: ConfigField, value: Binding<String>, isSecure: Binding<Bool>) {
    self.field = field
    self._value = value
    self._isSecure = isSecure
  }
  
  private var isPasswordField: Bool {
    field.type == .password
  }
  
  private var secureButton: some View {
    Button(action: {
      isSecure.toggle()
    }) {
      isSecure ? Image.eyeOff : Image.eyeOn
    }
  }
  
  private var prefix: ContentModel? {
    if field.type == .phone {
      return ContentModel(text: CoalString.zonePhone)
    } else {
      return nil
    }
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      OutlineTxtField(
        titleKey: LocalizedStringKey(field.placeholder ?? ""),
        text: $value,
        label: field.label ?? "",
        prefix: prefix
      )
      .setSecured($isSecure)
      .setRightView(isPasswordField ? secureButton : nil)
      .padding(.top, 10)
    }
  }
}
