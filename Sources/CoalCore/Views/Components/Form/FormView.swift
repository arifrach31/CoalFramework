//
//  FormView.swift
//
//
//  Created by ArifRachman on 19/11/24.
//

import SwiftUI

public protocol FormViewModelProtocol: ObservableObject {
  var isLoading: Bool { get }
  var isFormValid: Bool { get }
  var fieldErrors: [String: Bool] { get }
  var fieldErrorMessages: [String: String] { get }
  
  func binding(for field: ConfigField) -> Binding<String>
  func bindingSecure(for field: ConfigField) -> Binding<Bool>
}

public struct FormView<FormViewModel: FormViewModelProtocol>: View {
  @ObservedObject var viewModel: FormViewModel
  let formFields: [ConfigField]
  let forgotButton: ForgotButton?
  let forgotButtonAction: (() -> Void)?
  
  public init(
    viewModel: FormViewModel,
    formFields: [ConfigField],
    forgotButton: ForgotButton? = nil,
    forgotButtonAction: (() -> Void)? = nil
  ) {
    self.viewModel = viewModel
    self.formFields = formFields
    self.forgotButton = forgotButton
    self.forgotButtonAction = forgotButtonAction
  }
  
  public var body: some View {
    VStack(spacing: 12) {
      ForEach(formFields.indices, id: \.self) { index in
        let field = formFields[index]
        CoalTextFieldView(
          field: field,
          value: viewModel.binding(for: field),
          isSecure: viewModel.bindingSecure(for: field),
          isError: viewModel.fieldErrors[field.label ?? ""] ?? false,
          errorMessage: viewModel.fieldErrorMessages[field.label ?? ""] ?? "",
          forgotButton: index == formFields.count - 1 ? forgotButton : nil,
          forgotButtonAction: { _ in
            forgotButtonAction?()
          }
        )
      }
    }
    .padding(.vertical, 10)
  }
}
