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
      ForEach(form.filter { $0.type != .submit }) { field in
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
  @Binding var isAgreed: Bool
  
  var body: some View {
    HStack(alignment: .center, spacing: 4) {
      Checkbox(
        defaultIsChecked: isAgreed,
        size: .medium,
        onToggleChange: { isChecked in
          isAgreed = isChecked
        }
      )
      Text(CoalString.agreement)
        .LGNBodySmall(color: LGNColor.tertiary500)
      AnchorText(title: CoalString.termCondition, tintColor: Color.LGNTheme.secondary500)
        .variant(size: .small)
      Text(CoalString.and)
        .LGNBodySmall(color: LGNColor.tertiary500)
      AnchorText(title: CoalString.privacyPolicy, tintColor: Color.LGNTheme.secondary500)
        .variant(size: .small)
    }
    .padding(.horizontal, 10)
  }
}

private struct ButtonView: View {
  @ObservedObject var viewModel: RegisterViewModel
  let form: [ConfigField]
  @State private var isAgreed = false
  
  var body: some View {
    VStack(spacing: 10) {
      AgreementView(isAgreed: $isAgreed)
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonPrimary(field: field, isDisabled: !viewModel.isFormValid)  {
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
