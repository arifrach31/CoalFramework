//
//  LoginViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/09/24.
//

import SwiftUI
import Combine
import CoalCore

public class LoginViewModel: FormViewModelProtocol, ObservableObject {
  @Published public var isLoading: Bool = false
  @Published public var fieldErrors: [String: Bool] = [:]
  @Published public var fieldErrorMessages: [String: String] = [:]
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var formFields: [ConfigField]?
  
  public var isFormValid: Bool {
    validateFields()
  }
  
  public func binding(for field: ConfigField) -> Binding<String> {
    Binding<String>(
      get: { self.formValues[field.label ?? ""] ?? "" },
      set: { newValue in
        self.formValues[field.label ?? ""] = newValue
        self.clearErrors(for: field)
      }
    )
  }
  
  public func bindingSecure(for field: ConfigField) -> Binding<Bool> {
    Binding<Bool>(
      get: { self.isSecured[field.label ?? ""] ?? (field.type == .password) },
      set: { self.isSecured[field.label ?? ""] = $0 }
    )
  }
  
  func configure(with config: LoginConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  private func validateFields() -> Bool {
    let email = getFieldValue(for: .email) ?? ""
    let password = getFieldValue(for: .password) ?? ""
    
    return Validator(email, type: .email) && Validator(password, type: .password)
  }
  
  private func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields?.first { $0.type == type }
    return field.flatMap { formValues[$0.label ?? ""] }
  }
  
  private func handleLoginError(error: ApiErrorType) {
    if let emailField = formFields?.first(where: { $0.type == .email }) {
      setError(for: emailField, message: CoalString.emailError)
    }
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
