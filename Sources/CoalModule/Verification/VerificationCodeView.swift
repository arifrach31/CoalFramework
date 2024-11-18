//
//  VerificationCodeView.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import CoalCore

public struct VerificationCodeView: View {
  @EnvironmentObject var config: CoalConfig
  @StateObject private var viewModel: VerificationViewModel
  
  private let navigator: CoalNavigatorProtocol?
  private let methodField: ConfigField?
  private let verificationType: VerificationType?
  
  public init(
    navigator: CoalNavigatorProtocol? = nil,
    methodField: ConfigField? = nil,
    verificationType: VerificationType? = .login
  ) {
    _viewModel = StateObject(wrappedValue: VerificationViewModel())
    self.navigator = navigator
    self.methodField = methodField
    self.verificationType = verificationType
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.verificationConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .verificationCode,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isShowNavBar: true,
      isLoading: viewModel.isLoading
    ) {
      VStack(spacing: 20) {
        bottomSheetView
      }
    }.onAppear {
      viewModel.configure(with: config.verificationConfig)
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(
        configHeader: config.verificationConfig?.verificationCodeHeader,
        additionalText: viewModel.getSendToMasking(methodField: methodField),
        alignment: .center
      )
      .padding(.top, 20)
      .frame(maxWidth: .infinity)
      
      CodeFieldView(
        code: $viewModel.code,
        isError: viewModel.isError,
        isTimerActive: viewModel.isTimerActive,
        remainingTime: viewModel.remainingTime,
        onResetError: {
          viewModel.clearError()
        },
        onResendCode: {
          viewModel.resetTimer()
        })
      
      CoalButtonPrimary(
        field: viewModel.buttonVerifyCode,
        isDisabled: !viewModel.isOTPComplete || viewModel.isError
      ) {
        self.verificationType == .login ?
          self.handleVerifyOTP(sendTo: methodField?.label) :
            self.handleVerifyPassword(email: methodField?.label)
      }
      
      Spacer()
    }
    .onAppear {
        viewModel.startTimer()
    }
  }
  
  private func handleVerifyOTP(sendTo: String?) {
    viewModel.verifyOTP(sendTo: sendTo) { result in
      switch result {
      case .success:
        if let destination = config.loginConfig?.loginButtonAction {
          navigator?.navigate(destination)
        } else {
          navigator?.goTo(.home)
        }
      case .failure:
        break
      }
    }
  }
  
  private func handleVerifyPassword(email: String?) {
    viewModel.verifyPassword(email: email) { result in
      switch result {
      case .success:
        navigator?.goTo(.changePassword)
      case .failure:
        break
      }
    }
  }
}

#Preview {
  VerificationCodeView()
}
