//
//  VerificationMethodView.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import SwiftUI
import CoalCore
import CoalLogin
import LegionUI
import ThemeLGN

public struct VerificationMethodView: View {
  @StateObject private var viewModel: LoginViewModel
  private let navigator: CoalNavigatorProtocol?
  private let config: LoginConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: LoginConfig? = nil) {
    _viewModel = StateObject(wrappedValue: LoginViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .verificationMethod,
      leftAction: { navigator?.popToPreviousView() },
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
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.verificationMethodHeader)
      if let verificationMethods = config?.verificationMethods {
        VerificationButtonView(methods: verificationMethods, navigator: navigator)
      }
      Spacer()
    }
  }
}

private struct VerificationButtonView: View {
  let methods: [ConfigField]
  let navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(methods.indices, id: \.self) { index in
        let field = methods[index]
        VerificationButton(field: field, navigator: navigator)
          .padding(.bottom, 24)
      }
    }
    .padding(.top, 24)
  }
}

private struct VerificationButton: View {
  let field: ConfigField
  let navigator: CoalNavigatorProtocol?
  
  var body: some View {
    LGNOutlineButton(
      title: field.titleVerification,
      leftImage: field.iconVerification,
      tintBtnColor: LGNColor.tertiary400,
      tintPressedBtnColor: LGNColor.tertiary700,
      pressedBtnColor: .white,
      cornerRadius: 30
    ) {
      navigator?.showVerificationCodePage()
    }
    .variant(size: .medium, responsive: true)
  }
}

#Preview {
  VerificationMethodView()
}
