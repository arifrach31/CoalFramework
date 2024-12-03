//
//  CodeFieldView.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import ThemeLGN
import LegionUI

public struct CodeFieldView: View {
  @Binding private var code: [String]
  @FocusState private var focusedField: Int?
  
  private var isError: Bool
  private var isTimerActive: Bool
  private var remainingTime: Int
  private var onResetError: () -> Void
  private var onResendCode: () -> Void
  
  private var errorMessageText: String
  private var timerText: String
  private var resendButtonText: String
  private var errorMessageColor: Color
  private var resendButtonColor: Color
  private var focusedBorderColor: Color
  private var defaultBorderColor: Color
  
  public init(
    code: Binding<[String]>,
    isError: Bool,
    isTimerActive: Bool = true,
    remainingTime: Int = 15,
    onResetError: @escaping () -> Void,
    onResendCode: @escaping () -> Void,
    errorMessageText: String = CoalString.incorrectCodeMessage,
    timerText: String = CoalString.didNotReceiveCode,
    resendButtonText: String = CoalString.resendCodeMessage,
    errorMessageColor: Color = .red,
    resendButtonColor: Color = .blue,
    focusedBorderColor: Color = LGNColor.tertiary700,
    defaultBorderColor: Color = LGNColor.tertiary400
  ) {
    self._code = code
    self.isError = isError
    self.isTimerActive = isTimerActive
    self.remainingTime = remainingTime
    self.onResetError = onResetError
    self.onResendCode = onResendCode
    self.errorMessageText = errorMessageText
    self.timerText = timerText
    self.resendButtonText = resendButtonText
    self.errorMessageColor = errorMessageColor
    self.resendButtonColor = resendButtonColor
    self.focusedBorderColor = focusedBorderColor
    self.defaultBorderColor = defaultBorderColor
  }
  
  public var body: some View {
    VStack {
      otpCodeFields
      errorMessage
      timerView
    }
  }
  
  private var otpCodeFields: some View {
    HStack(spacing: 12) {
      Spacer()
      ForEach(0..<code.count, id: \.self) { index in
        CodeField(
          text: $code[index],
          isError: isError,
          errorColor: errorMessageColor,
          focusedBorderColor: focusedBorderColor,
          defaultBorderColor: defaultBorderColor
        )
        .focused($focusedField, equals: index)
        .onChange(of: code[index]) { newValue in
          handleFieldChange(for: index, newValue: newValue)
        }
      }
      Spacer()
    }
  }
  
  @ViewBuilder
  private var errorMessage: some View {
    if isError {
      Text(errorMessageText)
        .lgnCaptionLargeRegular(color: errorMessageColor)
        .padding(.top, 8)
    }
  }
  
  private var timerView: some View {
    CodeTimer(
      isTimerActive: isTimerActive,
      remainingTime: remainingTime,
      timerText: timerText,
      resendButtonText: resendButtonText,
      resendButtonColor: resendButtonColor,
      onResend: onResendCode
    )
  }
  
  private func handleFieldChange(for index: Int, newValue: String) {
    onResetError()
    if newValue.count == 1 {
      focusedField = index < code.count - 1 ? index + 1 : nil
    } else if newValue.isEmpty {
      focusedField = index > 0 ? index - 1 : nil
    }
  }
}

public struct CodeField: View {
  @Binding public var text: String
  @FocusState private var isFocused: Bool
  public var isError: Bool
  public var errorColor: Color
  public var focusedBorderColor: Color
  public var defaultBorderColor: Color
  
  public var body: some View {
    TextField("", text: $text)
      .keyboardType(.numberPad)
      .frame(width: 58, height: 80)
      .background(Color.white)
      .cornerRadius(10)
      .multilineTextAlignment(.center)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(isFocused ? focusedBorderColor : (isError ? errorColor : defaultBorderColor), lineWidth: 1)
      )
      .onChange(of: text) { newValue in
        if newValue.count > 1 {
          text = String(newValue.prefix(1))
        }
      }
      .focused($isFocused)
      .padding(.top, 56)
  }
}

public struct CodeTimer: View {
  public var isTimerActive: Bool
  public var remainingTime: Int
  public var timerText: String
  public var resendButtonText: String
  public var resendButtonColor: Color
  public let onResend: () -> Void
  
  public var body: some View {
    HStack {
      Spacer()
      timerMessageView
      Spacer()
    }
    .padding(.vertical, 24)
    .font(.footnote)
  }
  
  @ViewBuilder
  private var timerMessageView: some View {
    if isTimerActive {
      Text("\(timerText) \(resendButtonText) \(remainingTime)s")
        .foregroundColor(.gray)
    } else {
      HStack {
        Text(timerText)
          .foregroundColor(.gray)
        Button(resendButtonText, action: onResend)
          .foregroundColor(resendButtonColor)
      }
    }
  }
}
