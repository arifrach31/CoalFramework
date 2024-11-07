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
  @StateObject private var viewModel: ForgotViewModel
  private let navigator: CoalNavigatorProtocol?
  private let config: ForgotConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: ForgotConfig? = nil) {
    _viewModel = StateObject(wrappedValue: ForgotViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .back,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading,
      isShowingBottomSheet: $viewModel.isShowingBottomSheet,
      bottomSheetContent: AnyView(bottomSheetConfirmation)
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
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
      navigator?.goTo(.verificationCode(journey: .forgot, methodField: field))
      viewModel.isShowingBottomSheet.toggle()
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config?.header?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.header)
      if let form = config?.fields {
        FormView(
          viewModel: viewModel,
          form: form,
          config: config,
          navigator: navigator
        )
        
        ButtonView(
          viewModel: viewModel,
          form: form,
          navigator: navigator,
          config: config
        )
      }
      Spacer()
    }
  }
}

private struct FormView: View {
  @ObservedObject var viewModel: ForgotViewModel
  let form: [ConfigField]
  var config: ForgotConfig?
  var navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack() {
      let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
      ForEach(formFields.indices, id: \.self) { index in
        let field = formFields[index]
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field),
          isError: viewModel.fieldErrors[field.label ?? ""] ?? false,
          errorMessage: viewModel.fieldErrorMessages[field.label ?? ""] ?? ""
        )
      }
    }
    .padding(.vertical, 24)
  }
}

private struct ButtonView: View {
  @ObservedObject var viewModel: ForgotViewModel
  let form: [ConfigField]
  var navigator: CoalNavigatorProtocol?
  var config: ForgotConfig?
  
  var body: some View {
    VStack(spacing: 10) {
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonPrimary(field: field, isDisabled: !viewModel.isFormValid) {
          handleForgotPassword()
        }
        .padding(.vertical, 10)
      }
    }
  }
  
  private func handleForgotPassword() {
    viewModel.forgotPassword { result in
      switch result {
      case .success:
        viewModel.isShowingBottomSheet.toggle()
      case .failure:
        break
      }
    }
  }
}

#Preview {
  ForgotView()
}
