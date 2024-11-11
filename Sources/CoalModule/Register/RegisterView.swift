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
  @StateObject private var viewModel: RegisterViewModel
  public var navigator: CoalNavigatorProtocol?
  public var config: RegisterConfig?
  
  @State private var isToastVisible: Bool = false
  @State private var toastType: ToastType = .registerFailure
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: RegisterConfig? = nil) {
    _viewModel = StateObject(wrappedValue: RegisterViewModel(config: config))
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
      toastType: toastType
    ) {
      Spacer()
      bottomSheetView
    }
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.header)
      
      if let form = config?.fields {
        FormView(
          viewModel: viewModel, 
          form: form
        )
        ButtonView(
          viewModel: viewModel, 
          navigator: navigator,
          config: config,
          form: form
        )
      }
      Spacer()
      RegisterFooterView(navigator: navigator)
    }
  }
}

private struct FormView: View {
  @ObservedObject var viewModel: RegisterViewModel
  let form: [ConfigField]
  
  var body: some View {
    VStack(spacing: 12) {
      let formFields = form.filter { $0.type != .submit }
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
    .padding(.vertical, 10)
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
        onToggleChange: { isChecked in
          isAgreed = isChecked
        }
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

private struct ButtonView: View {
  @ObservedObject var viewModel: RegisterViewModel
  var navigator: CoalNavigatorProtocol?
  var config: RegisterConfig?
  let form: [ConfigField]
  @State private var isAgreed = false
  @EnvironmentObject public var coalEnvironment: CoalEnvironment
  
  private var isEnabled: Bool {
    return viewModel.isFormValid && isAgreed
  }
  
  var body: some View {
    VStack(spacing: 10) {
      AgreementView(
        navigator: navigator,
        config: config,
        isAgreed: $isAgreed
      )
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonPrimary(field: field, isDisabled: !isEnabled)  {
          verifyRegister()
        }
        .padding(.vertical, 10)
      }
    }
  }
  
  func verifyRegister() {
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

private struct RegisterFooterView: View {
  var navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack {
      Spacer()
      HStack(spacing: 0) {
        Spacer()
        Text(CoalString.alreadyHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        AnchorText(title: CoalString.loginTitle, tintColor: Color.LGNTheme.secondary500) {
          navigator?.goTo(.login)
        }.variant(size: .small)
        Spacer()
      }
      .padding(.bottom, 24)
    }
  }
}

#Preview {
  RegisterView()
}
