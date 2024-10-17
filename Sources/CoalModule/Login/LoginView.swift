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
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: LoginConfig? = nil) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config?.loginHeader?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, 60)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.loginHeader)
      if let form = config?.loginFields {
        FormView(viewModel: viewModel,
                 form: form,
                 additionalButtonConfig: config?.additionalButtonConfig)
        ButtonView(form: form, navigator: navigator)
      }
      Spacer()
      FooterView()
    }
  }
}

private struct FormView: View {
  @ObservedObject var viewModel: LoginViewModel
  let form: [ConfigField]
  var additionalButtonConfig: AdditionalButtonConfig?
  
  var body: some View {
    VStack(spacing: 12) {
      let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
      ForEach(formFields.indices, id: \.self) { index in
        let field = formFields[index]
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field),
          additionalButtonConfig: index == formFields.count - 1 ? additionalButtonConfig : nil
        )
      }
    }
    .padding(.vertical, 10)
  }
}

private struct ButtonView: View {
  let form: [ConfigField]
  var navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 10) {
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonView(field: field) {
          navigator?.showLoginVerificationMethodPage()
        }
        .padding(.vertical, 10)
      }
      
      HStack(spacing: 0) {
        Text(CoalString.doNotHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        AnchorText(title: CoalString.register, tintColor: Color.LGNTheme.secondary500) {
          navigator?.showRegisterPage(backgroundColor: .white)
        }.variant(size: .small)
      }
      .padding(.vertical, 10)
    }
  }
}

private struct FooterView: View {
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Spacer()
        Image.icInfo
          .frame(width: 16, height: 16)
          .foregroundColor(LGNColor.tertiary500)
        Text(CoalString.haveAccountProblem)
          .LGNBodySmall(color: LGNColor.tertiary500)
        Spacer()
      }
      AnchorText(title: CoalString.contactUs, tintColor: Color.LGNTheme.secondary500)
        .variant(size: .small)
    }
    .padding(.bottom, 24)
  }
}

#Preview {
  LoginView()
}
