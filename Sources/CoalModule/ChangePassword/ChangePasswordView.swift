//
//  ChangePasswordView.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct ChangePasswordView: View {
  @EnvironmentObject var config: CoalConfig
  @EnvironmentObject public var coalEnvironment: CoalEnvironment
  @StateObject private var viewModel: ChangePasswordViewModel
  private let navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    _viewModel = StateObject(wrappedValue: ChangePasswordViewModel())
    self.navigator = navigator
  }
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config.changePasswordConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      pageType: .back,
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
      viewModel.configure(with: config.changePasswordConfig)
    }
  }
  
  private var headerImage: some View {
    CoalImageView(imageURL: config.changePasswordConfig?.header?.image ?? "")
      .scaledToFill()
      .frame(width: 125, height: 125)
      .padding(.top, -8)
  }
  
  private var bottomSheetView: some View {
    BottomSheetView {
      AuthenticationHeaderView(configHeader: config.changePasswordConfig?.header)
      if let form = config.changePasswordConfig?.fields {
        let formFields = form.filter { $0.type != .checkbox && $0.type != .submit }
        FormView(
          viewModel: viewModel,
          formFields: formFields
        )
        
        ButtonView(
          viewModel: viewModel,
          form: form,
          isFormValid: viewModel.isFormValid,
          navigator: navigator,
          buttonAction: {
            handleChangePassword()
          }
        )
      }
      Spacer()
    }
  }
  
  func handleChangePassword() {
    viewModel.changePassword { result in
      switch result {
      case .success:
        coalEnvironment.toastType = .resetPasswordSuccess
        navigator?.goTo(.login)
      case .failure:
        coalEnvironment.toastType = .genericError
      }
    }
  }
}

#Preview {
  ChangePasswordView()
}
