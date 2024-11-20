//
//  ForgotViewModel.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import SwiftUI
import Combine
import CoalCore

class ForgotViewModel: FormViewModelProtocol, ObservableObject {
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var formFields: [ConfigField]?
  @Published var fieldErrors: [String: Bool] = [:]
  @Published var fieldErrorMessages: [String: String] = [:]
  @Published var isLoading: Bool = false
  @Published var isShowingBottomSheet = false
  
  var isFormValid: Bool {
    validateFields()
  }
  
  func configure(with config: ForgotConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  private func validateFields() -> Bool {
    let email = getFieldValue(for: .text) ?? ""
    
    return Validator(email, type: .text, minLength: 10)
  }
  
  private func handleForgotError(error: ApiErrorType) {
    if let emailField = formFields?.first(where: { $0.type == .text }) {
      setError(for: emailField, message: CoalString.forgotPasswordError)
    }
  }
  
  public func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields?.first { $0.type == type }
    return field.flatMap { formValues[$0.label ?? ""] }
  }
  
  func binding(for field: ConfigField) -> Binding<String> {
    Binding<String>(
      get: { self.formValues[field.label ?? ""] ?? "" },
      set: { newValue in
        self.formValues[field.label ?? ""] = newValue
        self.clearErrors(for: field)
      }
    )
  }
  
  func bindingSecure(for field: ConfigField) -> Binding<Bool> {
    Binding<Bool>(
      get: { self.isSecured[field.label ?? ""] ?? (field.type == .password) },
      set: { self.isSecured[field.label ?? ""] = $0 }
    )
  }
  
  func setError(for field: ConfigField, message: String) {
    fieldErrors[field.label ?? ""] = true
    fieldErrorMessages[field.label ?? ""] = message
  }
  
  func clearErrors(for field: ConfigField) {
    fieldErrors[field.label ?? ""] = false
    fieldErrorMessages[field.label ?? ""] = ""
  }
  
  func clearAllErrors() {
    if let form = formFields {
      for field in form {
        clearErrors(for: field)
      }
    }
  }
  
  func forgotPassword(completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
    guard let email = getFieldValue(for: .text) else {
      completion(.failure(.connectionError))
      return
    }
    
    isLoading = true
    NetworkManager.shared.request(
      endpoint: .forgotPassword(email: email),
      responseType: BaseResponseModel<UserData>.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          self?.handleForgotError(error: error)
          completion(.failure(error))
        }
      }
    }
  }
}
