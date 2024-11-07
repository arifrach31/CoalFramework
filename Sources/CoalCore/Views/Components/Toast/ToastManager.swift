//
//  ToastManager.swift
//
//
//  Created by M. Rizki Maulana on 05/11/24.
//

import SwiftUI

public class ToastManager: ObservableObject {
  public static let shared = ToastManager()
  @Published public var toastData: ToastModel?
  @Published public var isVisible: Bool = false
  
  public init() {}
  
  public func show(title: String, subtitle: String, isError: Bool = false) {
    self.toastData = nil
    self.isVisible = false
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      self.toastData = ToastModel(title: title, subtitle: subtitle, isError: isError)
      self.isVisible = true
    }
  }
  
  public func hide() {
    self.isVisible = false
    self.toastData = nil
  }
}
