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
  public var isError: Bool
  public var errorMessage: String?
  @FocusState private var isEmailFieldFocused: Bool
  
  public init(
    field: ConfigField,
    value: Binding<String>,
    isSecure: Binding<Bool>,
    additionalButtonConfig: AdditionalButtonConfig? = nil,
    isError: Bool = false,
    errorMessage: String? = nil
  ) {
    self.field = field
    self._value = value
    self._isSecure = isSecure
    self.additionalButtonConfig = additionalButtonConfig
    self.isError = isError
    self.errorMessage = errorMessage
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
      .state(isError ? .error : .idle)
      .focused($isEmailFieldFocused, equals: field.type == .email)
      .onChange(of: isError) { newValue in
        if newValue && field.type == .email {
          isEmailFieldFocused = true 
        }
      }
      if isError {
        HStack(alignment: .top) {
          Image(systemName: "exclamationmark.triangle")
            .foregroundColor(.red)
          
          Text(errorMessage ?? "")
            .lgnBodySmallRegular(color: Color.redButton)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 2)
      }
      
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
