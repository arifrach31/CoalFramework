//
//  CoalTextFieldView.swift
//  CoalFramework
//
//  Created by ArifRachman on 04/09/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct CoalTextFieldView: View {
  public let field: ConfigField
  @Binding public var value: String
  @Binding public var isSecure: Bool
  public var additionalButtonConfig: AdditionalButtonConfig?
  
  public init(field: ConfigField, 
              value: Binding<String>,
              isSecure: Binding<Bool>,
              additionalButtonConfig: AdditionalButtonConfig? = nil) {
    self.field = field
    self._value = value
    self._isSecure = isSecure
    self.additionalButtonConfig = additionalButtonConfig
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
      
      if additionalButtonConfig?.isVisible == true {
        if let additionalText = additionalButtonConfig?.text {
          HStack {
            AnchorText(title: additionalText, tintColor: Color.LGNTheme.secondary500)
              .variant(size: .small)
            Spacer()
          }
          .padding(.top, 5)
        }
      }
    }
  }
}
