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
  @FocusState private var isEmailFieldFocused: Bool
  @Binding private var value: String
  @Binding private var isSecure: Bool
  
  private let field: ConfigField
  private var isError: Bool
  private var errorMessage: String?
  private var forgotButton: ForgotButton?
  private var forgotButtonAction: (CoalScreenType) -> Void
  
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
    self.isError = isError
    self.errorMessage = errorMessage
    self.forgotButton = forgotButton
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
    field.type == .phone ? ContentModel(text: CoalString.zonePhone) : nil
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      textField
      errorMessageView
      forgotButtonView
    }
  }
  
  @ViewBuilder
  private var textField: some View {
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
  }
  
  @ViewBuilder
  private var errorMessageView: some View {
    if isError, let errorMessage = errorMessage {
      HStack(alignment: .top, spacing: 8) {
        Image.warningIcon
          .foregroundColor(.red)
        Text(errorMessage)
          .lgnBodySmallRegular(color: Color.redButton)
          .lineLimit(nil)
          .fixedSize(horizontal: false, vertical: true)
      }
      .padding(.top, 2)
    }
  }
  
  @ViewBuilder
  private var forgotButtonView: some View {
    if forgotButton?.isVisible == true, let forgotText = forgotButton?.text, let coalScreen = forgotButton?.coalScreen {
      HStack {
        AnchorText(title: forgotText, tintColor: Color.LGNTheme.secondary500) {
          forgotButtonAction(coalScreen)
        }
        .variant(size: .small)
        Spacer()
      }
      .padding(.top, 5)
    }
  }
}
