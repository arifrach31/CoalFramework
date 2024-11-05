//
//  WebViewViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/11/24.
//

import SwiftUI
import Combine
import CoalCore

public class WebViewViewModel: ObservableObject {
  @Published var isLoading: Bool = true
  @Published var hasError: Bool = false
  @Published var config: WebViewModel?
  
  private var cancellables = Set<AnyCancellable>()
  
  public init(config: WebViewModel?) {
    self.config = config
  }
  
  func retryLoading() {
    isLoading = true
    hasError = false
  }
  
  func updateLoadingState(isLoading: Bool, hasError: Bool) {
    self.isLoading = isLoading
    self.hasError = hasError
  }
}
