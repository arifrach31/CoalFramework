//
//  ButtonView.swift
//
//
//  Created by ArifRachman on 19/11/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct ButtonView<ViewModel: ObservableObject>: View {
  @ObservedObject var viewModel: ViewModel
  let form: [ConfigField]
  var isFormValid: Bool
  var navigator: CoalNavigatorProtocol?
  let buttonAction: (() -> Void)?
  
  public init(
    viewModel: ViewModel,
    form: [ConfigField],
    isFormValid: Bool = false,
    navigator: CoalNavigatorProtocol? = nil,
    buttonAction: (() -> Void)? = nil
  ) {
    self.viewModel = viewModel
    self.form = form
    self.isFormValid = isFormValid
    self.navigator = navigator
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
      
      HStack(spacing: 0) {
        Text(CoalString.doNotHaveAccount)
          .LGNBodySmall(color: LGNColor.tertiary500)
        AnchorText(title: CoalString.register, tintColor: Color.LGNTheme.secondary500) {
          navigator?.goTo(.register)
        }
        .variant(size: .small)
      }
      .padding(.vertical, 10)
    }
  }
}
