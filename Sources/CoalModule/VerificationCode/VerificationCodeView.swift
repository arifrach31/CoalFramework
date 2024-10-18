//
//  VerificationCodeView.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import CoalCore

public struct VerificationCodeView: View {
  @StateObject private var viewModel = VerificationCodeViewModel()
  
  private let navigator: CoalNavigatorProtocol?
  private let config: LoginConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: LoginConfig? = nil) {
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .verificationCode,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor
    ) {
      VStack(spacing: 20) {
        bottomSheetView
      }
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(
        configHeader: config?.loginHeader,
        alignment: .center
      ).padding(.top, 30)
      
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
      
      CoalButtonView(
        field:
          ConfigField(
            type: .submit,
            label: CoalString.verify
          ),
        isDisabled: !viewModel.isOTPComplete || viewModel.isError
      ) {
        if viewModel.verifyOTP(correctOTP: viewModel.correctOTP) {
          navigator?.showVerificationMethodPage()
        }
      }
      Spacer()
    }
    .onAppear {
      viewModel.startTimer()
    }
  }
}

#Preview {
  VerificationCodeView()
}
