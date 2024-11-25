//
//  RegisterViewModel.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 09/09/24.
//

import SwiftUI
import Combine
import CoalCore

class RegisterViewModel: FormViewModelProtocol, ObservableObject {
  @Published var isLoading: Bool = false
  @Published var fieldErrors: [String: Bool] = [:]
  @Published var fieldErrorMessages: [String: String] = [:]
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var formFields: [ConfigField]?
  @Published var isAgreed: Bool = false 
  
  var isFormValid: Bool {
    validateFields()
  }
  
  var isFormEnabled: Bool {
    isFormValid && isAgreed
  }
  
  func binding(for field: ConfigField) -> Binding<String> {
    Binding<String>(
      get: { self.formValues[field.label ?? ""] ?? "" },
      set: { self.formValues[field.label ?? ""] = $0 }
    )
  }
  
  func bindingSecure(for field: ConfigField) -> Binding<Bool> {
    Binding<Bool>(
      get: { self.isSecured[field.label ?? ""] ?? (field.type == .password || field.type == .confirmPassword) },
      set: { self.isSecured[field.label ?? ""] = $0 }
    )
  }
  
  func configure(with config: RegisterConfig?) {
    self.formFields = config?.fields ?? []
  }
  
  private func validateFields() -> Bool {
    let fullname = getFieldValue(for: .text) ?? ""
    let email = getFieldValue(for: .email) ?? ""
    let phone = getFieldValue(for: .phone) ?? ""
    let password = getFieldValue(for: .password) ?? ""
    let confirmPassword = getFieldValue(for: .confirmPassword) ?? ""
    
    let isFullnameValid = Validator(fullname, type: .text, isRequired: true)
    let isEmailValid = Validator(email, type: .email)
    let isPhoneValid = Validator(phone, type: .phone, isRequired: true)
    let isPasswordValid = Validator(password, type: .password)
    let isConfirmPasswordValid = Validator(confirmPassword, type: .confirmPassword, passwordToMatch: password)
    
    if let confirmPasswordField = formFields?.first(where: { $0.type == .confirmPassword }) {
      DispatchQueue.main.async {
        if !confirmPassword.isEmpty && password != confirmPassword {
          self.setError(for: confirmPasswordField)
        } else {
          self.clearErrors(for: confirmPasswordField)
        }
      }
    }
    
    return isFullnameValid && isEmailValid && isPhoneValid && isPasswordValid && isConfirmPasswordValid
  }
  
  private func getFieldValue(for type: ConfigFieldType) -> String? {
    let field = formFields?.first { $0.type == type }
    return field.flatMap { formValues[$0.label ?? ""] }
  }
  
  func setError(for field: ConfigField) {
    fieldErrors[field.label ?? ""] = field.isShowError
    fieldErrorMessages[field.label ?? ""] = field.errorMessage
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
  
  func verifyRegister() -> Bool {
    return true
  }
  
  func register(completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
    guard let fullName = getFieldValue(for: .text),
          let email = getFieldValue(for: .email),
          let phone = getFieldValue(for: .phone).map({ CoalString.zonePhone + $0 }),
          let password = getFieldValue(for: .password),
          let confirmPassword = getFieldValue(for: .confirmPassword) else {
      completion(.failure(.connectionError))
      return
    }
    
    isLoading = true
    NetworkManager.shared.request(
      endpoint: .register(
        fullname: fullName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        mobileNumber: phone
      ),
      responseType: UserData.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }
}
