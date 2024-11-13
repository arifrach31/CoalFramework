//
//  LoginViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import SwiftUI
import Combine
import CoalCore

public class LoginViewModel: ObservableObject {
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var formFields: [ConfigField]
  @Published var fieldErrors: [String: Bool] = [:]
  @Published var fieldErrorMessages: [String: String] = [:]
  @Published var isLoading: Bool = false
  
  public init(config: LoginConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  var isFormValid: Bool {
    validateFields()
  }
  
  private func validateFields() -> Bool {
    let email = getFieldValue(for: .email) ?? ""
    let password = getFieldValue(for: .password) ?? ""
    
    return Validator(email, type: .email) && Validator(password, type: .password)
  }
  
  private func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields.first { $0.type == type }
    return field.flatMap { formValues[$0.label ?? ""] }
  }
  
  private func handleLoginError(error: ApiErrorType) {
    if let emailField = formFields.first(where: { $0.type == .email }) {
      setError(for: emailField, message: CoalString.emailError)
    }
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
    for field in formFields {
      clearErrors(for: field)
    }
  }
  
  private func clearPassword() {
    formValues["password"] = ""
  }
  
  func login(completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
    guard let email = getFieldValue(for: .email),
          let password = getFieldValue(for: .password) else {
      completion(.failure(.connectionError))
      return
    }
    
    isLoading = true
    NetworkManager.shared.request(
      endpoint: .login(username: email, password: password),
      responseType: CoalUser.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success(let response):
          response.save()
          self?.clearAllErrors()
          completion(.success(()))
        case .failure(let error):
          self?.handleLoginError(error: error)
          self?.clearPassword()
          completion(.failure(error))
        }
      }
    }
  }
}
