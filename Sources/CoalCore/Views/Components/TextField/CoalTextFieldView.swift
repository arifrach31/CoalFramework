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
  @FocusState private var isEmailFieldFocused: Bool
  @Binding public var value: String
  @Binding public var isSecure: Bool
  public var isError: Bool
  public var errorMessage: String?
  public var forgotButton: ForgotButton?
  public var forgotButtonAction: (CoalScreenType) -> Void
  
  public init(
    field: ConfigField,
    value: Binding<String>,
    isSecure: Binding<Bool>,
    isError: Bool = false,
    errorMessage: String? = nil,
    forgotButton: ForgotButton? = nil,
    forgotButtonAction: @escaping (CoalScreenType) -> Void = { _ in }
  ) {
    self.field = field
    self._value = value
    self._isSecure = isSecure
    self.forgotButton = forgotButton
    self.isError = isError
    self.errorMessage = errorMessage
    self.forgotButtonAction = forgotButtonAction
  }
  
  private var isPasswordField: Bool {
    field.type == .password || field.type == .confirmPassword
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
          Image.warningIcon
            .foregroundColor(.red)
          
          Text(errorMessage ?? "")
            .lgnBodySmallRegular(color: Color.redButton)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 2)
      }
      
      if forgotButton?.isVisible == true {
        if let forgotText = forgotButton?.text {
          HStack {
            AnchorText(title: forgotText, tintColor: Color.LGNTheme.secondary500) {
              if let coalScreen = forgotButton?.coalScreen {
                forgotButtonAction(coalScreen)
              }
            }.variant(size: .small)
            Spacer()
          }
          .padding(.top, 5)
        }
      }
    }
  }
}
