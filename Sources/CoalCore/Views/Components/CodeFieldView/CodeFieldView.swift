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
  @Binding var code: [String]
  @FocusState private var focusedField: Int?
  
  var isError: Bool
  var isTimerActive: Bool
  var remainingTime: Int
  var onResetError: () -> Void
  var onResendCode: () -> Void
  
  var errorMessageText: String
  var timerText: String
  var resendButtonText: String
  var errorMessageColor: Color
  var resendButtonColor: Color
  var focusedBorderColor: Color
  var defaultBorderColor: Color
  
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
  
  private var errorMessage: some View {
    Group {
      if isError {
        Text(errorMessageText)
          .foregroundColor(errorMessageColor)
          .padding(.top, 8)
      }
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
  @Binding var text: String
  @FocusState private var isFocused: Bool
  var isError: Bool
  var errorColor: Color
  var focusedBorderColor: Color
  var defaultBorderColor: Color
  
  public var body: some View {
    TextField("", text: $text)
      .keyboardType(.numberPad)
      .frame(width: 58, height: 80)
      .background(Color.white)
      .cornerRadius(10)
      .multilineTextAlignment(.center)
      .overlay(
        RoundedRectangle(cornerRadius: 10)
          .stroke(isFocused ? focusedBorderColor : (isError ? errorColor : defaultBorderColor), lineWidth: 2)
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
  var isTimerActive: Bool
  var remainingTime: Int
  var timerText: String
  var resendButtonText: String
  var resendButtonColor: Color
  let onResend: () -> Void
  
  public var body: some View {
    HStack {
      Spacer()
      timerMessageView
      Spacer()
    }
    .padding(.vertical, 24)
    .font(.footnote)
  }
  
  private var timerMessageView: some View {
    Group {
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
}
