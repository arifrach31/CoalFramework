//
//  ForgotView.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct ForgotView: View {
  @EnvironmentObject var config: CoalConfig
  @StateObject private var viewModel: ForgotViewModel
  private let navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: ForgotViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.forgotConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .back,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading,
      isShowingBottomSheet: $viewModel.isShowingBottomSheet,
      bottomSheetContent: bottomSheetConfirmation
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
    }.onAppear {
      viewModel.configure(with: config.forgotConfig)
    }
  }
  
  private var bottomSheetConfirmation: some View {
    BottomSheetConfirmationView(
      title: CoalString.otpSentTitle,
      description: CoalString.otpSentDescription,
      buttonTitle: CoalString.otpSentButtonOK) {
        handleForgot()
      }
  }
  
  private func handleForgot() {
    if let emailFieldValue = viewModel.getFieldValue(for: .text) {
      let field = ConfigField(type: .text, label: emailFieldValue)
      navigator?.goTo(.verificationCode(type: .forgot, methodField: field))
      viewModel.isShowingBottomSheet.toggle()
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config.forgotConfig?.header?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      FormHeaderView(configHeader: config.forgotConfig?.header)
      if let form = config.forgotConfig?.fields {
        let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
        
        FormView(
          viewModel: viewModel,
          formFields: formFields
        )
        
        FormButtonView(
          viewModel: viewModel,
          form: form,
          isFormValid: viewModel.isFormValid,
          navigator: navigator,
          buttonAction: {
            handleForgotPassword()
          }
        )
      }
      Spacer()
    }
  }
  
  private func handleForgotPassword() {
    viewModel.forgotPassword { result in
      switch result {
      case .success:
        viewModel.isShowingBottomSheet.toggle()
      case .failure: break
      }
    }
  }
}

#Preview {
  ForgotView()
}
