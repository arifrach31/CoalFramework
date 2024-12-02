//
//  RegisterView.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 09/09/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct RegisterView: View {
  @EnvironmentObject var config: CoalConfig
  @EnvironmentObject public var coalEnvironment: CoalEnvironment
  @StateObject private var viewModel: RegisterViewModel
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: RegisterViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.registerConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .back,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading,
      isScrollView: true
    ) {
      bottomSheetView
    }
    .onAppear {
      viewModel.configure(with: config.registerConfig)
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      FormHeaderView(configHeader: config.registerConfig?.header)
      
      if let form = config.registerConfig?.fields {
        let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
        
        FormView(viewModel: viewModel, formFields: formFields)
        
        AgreementView(
          navigator: navigator,
          config: config.registerConfig,
          isAgreed: $viewModel.isAgreed
        )
        
        FormButtonView(
          viewModel: viewModel,
          form: form,
          isFormValid: viewModel.isFormEnabled,
          navigator: navigator,
          additionalAchorText: AdditionalAchorText(
            text: CoalString.alreadyHaveAccount,
            achorText: CoalString.loginTitle,
            coalScreen: .login
          ),
          buttonAction: {
            handleRegister()
          }
        )
      }
      Spacer()
    }
  }
  
  func handleRegister() {
    viewModel.register { result in
      switch result {
      case .success:
        coalEnvironment.toastType = .registerSuccess
        navigator?.goTo(.login)
      case .failure:
        coalEnvironment.toastType = .registerFailure
      }
    }
  }
}

private struct AgreementView: View {
  var navigator: CoalNavigatorProtocol?
  var config: RegisterConfig?
  @Binding var isAgreed: Bool
  
  var body: some View {
    HStack(alignment: .center, spacing: 0) {
      Checkbox(
        defaultIsChecked: isAgreed,
        size: .medium,
        onToggleChange: { isAgreed = $0 }
      )
      .padding(.trailing, 4)
      
      Text(CoalString.agreement)
        .LGNBodySmall(color: LGNColor.tertiary500)
        .padding(.trailing, 2)
      
      AnchorText(title: CoalString.termCondition, tintColor: Color.LGNTheme.secondary500) {
        navigator?.goTo(.webview(model: config?.termCondition))
      }
      .variant(size: .small)
      .underlined()
      
      Text(CoalString.and)
        .LGNBodySmall(color: LGNColor.tertiary500)
        .padding(.horizontal, 2)
      
      AnchorText(title: CoalString.privacyPolicy, tintColor: Color.LGNTheme.secondary500) {
        navigator?.goTo(.webview(model: config?.privacyPolicy))
      }
      .variant(size: .small)
      .underlined()
    }
    .padding(.horizontal, 10)
  }
}

#Preview {
  RegisterView()
}
