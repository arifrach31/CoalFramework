//
//  VerificationMethodView.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct VerificationMethodView: View {
  @EnvironmentObject var config: CoalConfig
  @StateObject private var viewModel: VerificationViewModel
  private let navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: VerificationViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.verificationConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .verificationMethod,
      leftAction: { navigator?.popToPreviousView() },
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      isLoading: viewModel.isLoading
    ) {
      VStack(spacing: 40) {
        headerImage
        Spacer()
        bottomSheetView
      }
    }.onAppear {
      viewModel.configure(with: config.verificationConfig)
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config.verificationConfig?.verificationMethodHeader?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config.verificationConfig?.verificationMethodHeader)
      if let verificationMethods = viewModel.sendTo {
        VerificationButtonView(viewModel: viewModel, methods: verificationMethods, navigator: navigator)
      }
      Spacer()
    }
  }
}

private struct VerificationButtonView: View {
  @ObservedObject var viewModel: VerificationViewModel
  let methods: [ConfigField]
  let navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(Array(methods.enumerated()), id: \.offset) { _, field in
        CoalButtonSecondary(field: field) {
          self.handleSendOTP(field: field)
        }
        .padding(.bottom, 16)
      }
    }
    .padding(.top, 24)
  }

  private func handleSendOTP(field: ConfigField) {
    viewModel.sendOTP(method: field) { result in
      switch result {
      case .success:
        navigator?.goTo(
          .verificationCode(
            type: .login,
            methodField: field
          )
        )
      case .failure:
        break
      }
    }
  }
}

#Preview {
  VerificationMethodView()
}
