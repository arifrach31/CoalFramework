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
    }.onAppear {
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
      AuthenticationHeaderView(configHeader: config.loginConfig?.header)
      if let form = config.loginConfig?.fields {
        FormView(
          viewModel: viewModel,
          form: form,
          config: config.loginConfig,
          navigator: navigator
        )
        ButtonView(
          viewModel: viewModel,
          form: form,
          navigator: navigator,
          config: config.loginConfig
        )
      }
      Spacer()
    }
  }
}

private struct FormView: View {
  @ObservedObject var viewModel: LoginViewModel
  let form: [ConfigField]
  var config: LoginConfig?
  var navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 12) {
      let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
      ForEach(formFields.indices, id: \.self) { index in
        let field = formFields[index]
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field),
          isError: viewModel.fieldErrors[field.label ?? ""] ?? false, 
          errorMessage: viewModel.fieldErrorMessages[field.label ?? ""] ?? "",
          forgotButton: index == formFields.count - 1 ? config?.forgotButton : nil,
          forgotButtonAction: { screen in
            navigator?.goTo(screen)
          }
        )
      }
    }
    .padding(.vertical, 10)
  }
}

private struct ButtonView: View {
  @ObservedObject var viewModel: LoginViewModel
  let form: [ConfigField]
  var navigator: CoalNavigatorProtocol?
  var config: LoginConfig?
  
  var body: some View {
    VStack(spacing: 10) {
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonPrimary(field: field, isDisabled: !viewModel.isFormValid) {
          handleLogin()
        }
        .padding(.vertical, 10)
      }
      
      HStack(spacing: 0) {
        Text(CoalString.doNotHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        AnchorText(title: CoalString.register, tintColor: Color.LGNTheme.secondary500) {
          navigator?.goTo(.register)
        }.variant(size: .small)
      }
      .padding(.vertical, 10)
    }
  }
  
  private func handleLogin() {
    viewModel.login { result in
      switch result {
      case .success:
        navigator?.goTo(.verificationMethod)
      case .failure:
        break
      }
    }
  }
}

#Preview {
  LoginView()
}
