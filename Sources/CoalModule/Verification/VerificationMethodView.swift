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
  @StateObject private var viewModel: VerificationViewModel
  private let navigator: CoalNavigatorProtocol?
  private let config: VerificationConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: VerificationConfig? = nil) {
    _viewModel = StateObject(wrappedValue: VerificationViewModel(config: config))
    self.navigator = navigator
    self.config = config
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
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
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config?.verificationMethodHeader?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.verificationMethodHeader)
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
        navigator?.goTo(.verificationCode(methodField: field))
      case .failure:
        break
      }
    }
  }
}

#Preview {
  VerificationMethodView()
}
