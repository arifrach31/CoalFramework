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
    let (backgroundImage, backgroundColor) = getBackground()
    
    CoalBaseView(backgroundImage: backgroundImage, backgroundColor: backgroundColor) {
      VStack(spacing: 40) {
        CoalImageView(imageURL: config?.loginHeader?.image ?? "")
          .scaledToFill()
          .frame(width: 125, height: 125)
          .padding(.top, 60)
        Spacer()
        bottomSheetView
      }
    }
  }
  
  private func getBackground() -> (Image?, Color?) {
    let backgroundImageName = config?.backgroundImageName ?? ""
    let backgroundColorHex = config?.backgroundColor ?? ""
    
    let backgroundImage: Image? = backgroundImageName.isEmpty ? nil : Image(backgroundImageName)
    let backgroundColor: Color? = backgroundColorHex.isEmpty ? nil : Color(hex: backgroundColorHex)
    
    return (backgroundImage, backgroundColor)
  }
  
  private var bottomSheetView: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        HeaderView(configHeader: config?.loginHeader)
        if let form = config?.loginFields {
          FormView(viewModel: viewModel,
                   form: form,
                   forgotButtonConfig: config?.forgotButtonConfig)
          ButtonView(form: form, navigator: navigator)
        }
        Spacer()
        FooterView()
      }
      .padding(.horizontal, 20)
    }
  }
}

private struct HeaderView: View {
  let configHeader: ConfigHeader?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}

private struct FormView: View {
  @ObservedObject var viewModel: LoginViewModel
  let form: [ConfigField]
  var forgotButtonConfig: ForgotButtonConfig?
  
  var body: some View {
    VStack(spacing: 12) {
      let filteredFields = form.filter { $0.type != .checkbox && $0.type != .submit }
      ForEach(filteredFields.indices, id: \.self) { index in
        let field = filteredFields[index]
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field),
          forgotButtonConfig: index == filteredFields.count - 1 ? forgotButtonConfig : nil
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
          navigator?.showHomePage()
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

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
