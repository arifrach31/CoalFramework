//
//  ButtonView.swift
//
//
//  Created by ArifRachman on 19/11/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct AdditionalAchorText {
  public let text: String?
  public let achorText: String?
  public let coalScreen: CoalScreenType?
  
  public init(text: String?, achorText: String?, coalScreen: CoalScreenType? = .register) {
    self.text = text
    self.achorText = achorText
    self.coalScreen = coalScreen
  }
}

public struct ButtonView<ViewModel: ObservableObject>: View {
  @ObservedObject var viewModel: ViewModel
  let form: [ConfigField]
  let isFormValid: Bool
  let navigator: CoalNavigatorProtocol?
  let buttonAction: (() -> Void)?
  let additionalAchorText: AdditionalAchorText?
  
  public init(
    viewModel: ViewModel,
    form: [ConfigField],
    isFormValid: Bool = false,
    navigator: CoalNavigatorProtocol? = nil,
    additionalAchorText: AdditionalAchorText? = nil,
    buttonAction: (() -> Void)? = nil
  ) {
    self.viewModel = viewModel
    self.form = form
    self.isFormValid = isFormValid
    self.navigator = navigator
    self.additionalAchorText = additionalAchorText
    self.buttonAction = buttonAction
  }
  
  public var body: some View {
    VStack(spacing: 10) {
      ForEach(form.filter { $0.type == .submit }) { field in
        CoalButtonPrimary(field: field, isDisabled: !isFormValid) {
          buttonAction?()
        }
        .padding(.vertical, 10)
      }
      
      if additionalAchorText != nil,
         let text = additionalAchorText?.text,
         let achorText = additionalAchorText?.achorText,
         let coalScreen = additionalAchorText?.coalScreen {
        HStack(spacing: 0) {
          Text(text)
            .LGNBodySmall(color: LGNColor.tertiary500)
          AnchorText(title: achorText, tintColor: Color.LGNTheme.secondary500) {
            navigator?.goTo(coalScreen)
          }
          .variant(size: .small)
        }
        .padding(.vertical, 10)
      }
    }
  }
}
