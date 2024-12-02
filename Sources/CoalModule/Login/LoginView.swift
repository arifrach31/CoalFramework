//
//  LoginView.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct LoginView: View {
  @EnvironmentObject var config: CoalConfig
  @StateObject private var viewModel: LoginViewModel
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: LoginViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.loginConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
    }
    .onAppear {
      viewModel.configure(with: config.loginConfig)
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config.loginConfig?.header?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, 60)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      FormHeaderView(configHeader: config.loginConfig?.header)
      if let form = config.loginConfig?.fields {
        let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
        
        FormView(
          viewModel: viewModel,
          formFields: formFields,
          forgotButton: config.loginConfig?.forgotButton,
          forgotButtonAction: {
            if let screen = config.loginConfig?.forgotButton?.coalScreen {
              navigator?.goTo(screen)
            }
          }
        )
        
        FormButtonView(
          viewModel: viewModel,
          form: form,
          isFormValid: viewModel.isFormValid,
          navigator: navigator,
          additionalAchorText: AdditionalAchorText(
            text: CoalString.doNotHaveAccount,
            achorText: CoalString.register,
            coalScreen: .register
          ),
          buttonAction: {
            handleLogin()
          }
        )
      }
      Spacer()
    }
  }
  
  private func handleLogin() {
    viewModel.login { result in
      switch result {
      case .success:
        handleLoginSuccess()
      case .failure: break
      }
    }
  }
  
  private func handleLoginSuccess() {
    if config.loginConfig?.verificationEnabled == true {
      navigator?.goTo(.verificationMethod)
    } else {
      if let destination = config.loginConfig?.loginButtonAction {
        navigator?.navigate(destination)
      } else {
        navigator?.goTo(.home)
      }
    }
  }
}

#Preview {
  LoginView()
}
