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
  
  public let correctEmail = "emaildummy@gmail.com"
  
  public init(config: LoginConfig?) {
    self.formFields = config?.loginFields ?? []
  }
  
  var isFormValid: Bool {
    let emailField = formFields.first(where: { $0.type == .email })
    let passwordField = formFields.first(where: { $0.type == .password })
    
    let email = formValues[emailField?.label ?? ""] ?? ""
    let password = formValues[passwordField?.label ?? ""] ?? ""
    
    let isEmailValid = Validator(email, type: .email)
    let isPasswordValid = Validator(password, type: .password)
    
    return isEmailValid && isPasswordValid
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
  
  func verifyEmail(correctEmail: String) -> Bool {
    let emailField = formFields.first(where: { $0.type == .email })
    let email = formValues[emailField?.label ?? ""] ?? ""
    
    if email == correctEmail {
      fieldErrors[emailField?.label ?? ""] = false
      fieldErrorMessages[emailField?.label ?? ""] = ""
      return true
    } else {
      fieldErrors[emailField?.label ?? ""] = true
      fieldErrorMessages[emailField?.label ?? ""] = CoalString.emailError
      clearPassword()
      return false
    }
  }
  
  func clearPassword() {
    let passwordField = formFields.first(where: { $0.type == .password })
    
    if let passwordFieldLabel = passwordField?.label {
      formValues[passwordFieldLabel] = ""
    }
  }
}
