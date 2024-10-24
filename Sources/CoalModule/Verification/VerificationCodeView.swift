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
  private let sendTo: String?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: VerificationConfig? = nil, sendTo: String? = "") {
    _viewModel = StateObject(wrappedValue: VerificationViewModel())
    self.navigator = navigator
    self.config = config
    self.sendTo = sendTo
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .verificationCode,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isShowNavBar: true
    ) {
      VStack(spacing: 20) {
        bottomSheetView
      }
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      VStack(spacing: 0) {
        AuthenticationHeaderView(
          configHeader: config?.verificationCodeHeader,
          additionalParam: (sendTo ?? config?.sendVerificationCodeTo) ?? "",
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
}

#Preview {
  VerificationCodeView()
}
