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
  private let backgroundColor: Color
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: ConfigModel? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: RegisterViewModel(config: config))
    self.backgroundColor = backgroundColor
    self.navigator = navigator
  }
  
  public var body: some View {
    CoalBaseView(backgroundImage: Image.mainBackground, 
                 backgroundColor: backgroundColor) {
      VStack(spacing: 40) {
        Spacer()
        bottomSheetView
      }
    }
  }
  
  private var bottomSheetView: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        RegisterHeaderView(configHeader: viewModel.configHeader)
        if let form = viewModel.formFields {
          RegisterFormView(form: form, viewModel: viewModel)
          RegisterButtonView(form: form)
        }
        Spacer()
        RegisterFooterView(navigator: navigator)
      }
      .padding(.horizontal, 20)
    }
  }
}

private struct RegisterHeaderView: View {
  let configHeader: ConfigHeader?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(configHeader?.title ?? CoalString.register)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.registerDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}

private struct RegisterFormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: RegisterViewModel
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(form.filter { $0.type != .submit }) { field in
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field)
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

private struct RegisterButtonView: View {
  let form: [ConfigField]
  @State private var isAgreed = false
  
  var body: some View {
    VStack(spacing: 10) {
      AgreementView(isAgreed: $isAgreed)
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonView(field: field, isDisabled: !isAgreed)
          .padding(.vertical, 10)
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
          navigator?.showInitialPage(isLoggedIn: false)
        }.variant(size: .small)
        Spacer()
      }
      .padding(.bottom, 24)
    }
  }
}

//struct RegisterView_Previews: PreviewProvider {
//  static var previews: some View {
//    RegisterView()
//  }
//}
