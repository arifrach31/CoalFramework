//
//  RegisterViewModel.swift
//  CoalFramework
//
//  Created by M. Rizki Maulana on 09/09/24.
//

import SwiftUI
import Combine
import CoalModel

class RegisterViewModel: ObservableObject {
  @Published var formValues: [String: String] = [:]
  @Published var isSecured: [String: Bool] = [:]
  @Published var config: ConfigModel?
  
  var configHeader: ConfigHeader? {
    config?.pages?.register?.header
  }
  
  var formFields: [ConfigField]? {
    config?.pages?.register?.fields
  }
  
  init(config: ConfigModel? = nil) {
    self.config = config
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
}
