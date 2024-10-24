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
    CoalImageView(imageURL: config?.verificationMethodHeader?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config?.verificationMethodHeader)
      VerificationButtonView(methods: config?.verificationField ?? viewModel.sendTo, navigator: navigator)
      Spacer()
    }
  }
}

private struct VerificationButtonView: View {
  let methods: [ConfigField]
  let navigator: CoalNavigatorProtocol?
  
  var body: some View {
    VStack(spacing: 12) {
      ForEach(Array(methods.enumerated()), id: \.offset) { _, field in
        CoalButtonSecondary(field: field) {
          if let sendTo = field.label {
            navigator?.showVerificationCodePage(sendTo: maskingAccount(sendTo, type: field.type))
          }
        }
        .padding(.bottom, 16)
      }
    }
    .padding(.top, 24)
  }
}

#Preview {
  VerificationMethodView()
}
