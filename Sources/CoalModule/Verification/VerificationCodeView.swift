//
//  VerificationCodeView.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import CoalCore

public struct VerificationCodeView: View {
  @StateObject private var viewModel: VerificationViewModel
  
  private let navigator: CoalNavigatorProtocol?
  private let config: VerificationConfig?
  private let methodField: ConfigField?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: VerificationConfig? = nil, methodField: ConfigField? = nil) {
    _viewModel = StateObject(wrappedValue: VerificationViewModel(config: config))
    self.navigator = navigator
    self.config = config
    self.methodField = methodField
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
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
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(
        configHeader: config?.verificationCodeHeader,
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
        self.handleVerifyOTP(sendTo: methodField?.label)
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
        navigator?.goTo(.home)
      case .failure:
        break
      }
    }
  }
}

#Preview {
  VerificationCodeView()
}
