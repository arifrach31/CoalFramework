//
//  LoginView.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import UIKit
import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct LoginView: View {
  @StateObject private var viewModel: LoginViewModel
  public var navigator: CoalNavigatorProtocol?
  public var config: LoginConfig?
  
  @EnvironmentObject public var coalEnvironment: CoalEnvironment
  @State private var isToastVisible: Bool = false
  
  public init(
    navigator: CoalNavigatorProtocol? = nil,
    config: LoginConfig? = nil
  ) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading,
      isToastVisible: $isToastVisible,
      toastType: .registerSuccess
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
    }
    .onReceive(coalEnvironment.$isRegisteredsuccessful) { isRegisteredsuccessful in
      if let isRegisteredsuccessful = isRegisteredsuccessful, isRegisteredsuccessful {
        isToastVisible = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          isToastVisible = false
        }
      }
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config?.header?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, 60)
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
          additionalButtonConfig: index == formFields.count - 1 ? config?.additionalButtonConfig : nil,
          isError: viewModel.fieldErrors[field.label ?? ""] ?? false,
          errorMessage: viewModel.fieldErrorMessages[field.label ?? ""] ?? "",
          additionalButtonAction: { screen in
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
