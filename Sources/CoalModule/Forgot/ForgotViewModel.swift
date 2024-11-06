//
//  ForgotViewModel.swift
//
//
//  Created by ArifRachman on 01/11/24.
//

import SwiftUI
import Combine
import CoalCore

class ForgotViewModel: ObservableObject {
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var formFields: [ConfigField]
  @Published var fieldErrors: [String: Bool] = [:]
  @Published var fieldErrorMessages: [String: String] = [:]
  @Published var isLoading: Bool = false
  @Published var isShowingBottomSheet = false
  
  public init(config: ForgotConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  var isFormValid: Bool {
    validateFields()
  }
  
  private func validateFields() -> Bool {
    let email = getFieldValue(for: .text) ?? ""
    
    return Validator(email, type: .text, minLength: 10)
  }
  
  public func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields.first { $0.type == type }
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
    for field in formFields {
      clearErrors(for: field)
    }
  }
}
