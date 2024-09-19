//
//  LoginView.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import UIKit
import SwiftUI
import CoalCore
import CoalModel
import CoalView
import LegionUI
import ThemeLGN

public struct LoginView: View {
  @StateObject private var viewModel: LoginViewModel
  private let clientLogoName: String?
  private let backgroundColor: Color
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: ConfigModel? = nil, clientLogoName: String? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.clientLogoName = clientLogoName
    self.backgroundColor = backgroundColor
    self.navigator = navigator
  }
  
  public var body: some View {
    CoalBaseView(backgroundImage: Image.mainBackground, backgroundColor: backgroundColor) {
      VStack(spacing: 40) {
        headerView
        Spacer()
        bottomSheetView
      }
    }
  }
  
  private var headerView: some View {
    HeaderImageView(clientImageName: clientLogoName, remoteImageURL: viewModel.configHeader?.image)
      .frame(width: 125, height: 125)
      .padding(.top, 60)
  }
  
  private var bottomSheetView: some View {
    LGNBottomSheet(isShowing: .constant(true), dragable: false) {
      VStack(alignment: .leading, spacing: 5) {
        HeaderView(configHeader: viewModel.configHeader)
        if let form = viewModel.formFields {
          FormView(form: form, viewModel: viewModel)
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

private struct HeaderImageView: View {
  let clientImageName: String?
  let remoteImageURL: String?
  
  var body: some View {
    Group {
      if let urlString = remoteImageURL, let url = URL(string: urlString) {
        AsyncImage(url: url) { image in
          image.resizable().scaledToFit()
        } placeholder: {
          ProgressView()
        }
      } else if let imageName = clientImageName, let image = UIImage(named: imageName) {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Image.logo
          .resizable()
          .scaledToFit()
      }
    }
  }
}

private struct FormView: View {
  let form: [ConfigField]
  @ObservedObject var viewModel: LoginViewModel
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(form.filter { $0.type != .checkbox && $0.type != .submit }) { field in
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

private struct ButtonView: View {
  let form: [ConfigField]
  var navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Spacer()
        AnchorText(title: CoalString.forgotUsernameOrPassword, tintColor: Color.LGNTheme.secondary500)
          .variant(size: .small)
      }
      
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonView(field: field)
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
