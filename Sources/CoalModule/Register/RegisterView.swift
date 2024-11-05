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
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: RegisterConfig? = nil) {
    _viewModel = StateObject(wrappedValue: RegisterViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor
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
          form: form,
          viewModel: viewModel
        )
        ButtonView(
          navigator: navigator,
          config: config,
          viewModel: viewModel,
          form: form
        )
      }
      Spacer()
      RegisterFooterView(navigator: navigator)
    }
  }
}

private struct FormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: RegisterViewModel
  
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
  var navigator: CoalNavigatorProtocol?
  var config: RegisterConfig?
  @ObservedObject var viewModel: RegisterViewModel
  let form: [ConfigField]
  @State private var isAgreed = false
  
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
    //    viewModel.verifyRegister()
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
