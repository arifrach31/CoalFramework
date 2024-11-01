//
//  RegisterViewModel.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 09/09/24.
//

import SwiftUI
import Combine
import CoalCore

class RegisterViewModel: ObservableObject {
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var config: ConfigModel?
  
  @Published var formFields: [ConfigField]
  @Published var fieldErrors: [String: Bool] = [:]
  @Published var fieldErrorMessages: [String: String] = [:]
  @Published var isLoading: Bool = false
  
  public init(config: RegisterConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  var isFormValid: Bool {
    validateFields()
  }
  
  private func validateFields() -> Bool {
    let fullname = getFieldValue(for: .text) ?? ""
    let email = getFieldValue(for: .email) ?? ""
    let password = getFieldValue(for: .password) ?? ""
    
    let isFullnameValid = Validator(fullname, type: .text, isRequired: true)
    let isEmailValid = Validator(email, type: .email)
    let isPasswordValid = Validator(password, type: .password)
    
    return isEmailValid && isPasswordValid && isFullnameValid
  }
  
  private func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields.first { $0.type == type }
    return field.flatMap { formValues[$0.label ?? ""] }
  }
  
  func binding(for field: ConfigField) -> Binding<String> {
    Binding<String>(
      get: { self.formValues[field.label ?? ""] ?? "" },
      set: { self.formValues[field.label ?? ""] = $0 }
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
  
  func verifyRegister() -> Bool {
    return true
  }
  
  func register(completion: @escaping (Result<Void, ApiError>) -> Void) {
    
  }
}
