//
//  VerificationCodeViewModel.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import Combine

public class VerificationCodeViewModel: ObservableObject {
  @Published var code: [String] = Array(repeating: "", count: 4)
  @Published var isError: Bool = false
  @Published var remainingTime: Int = 15
  @Published var isTimerActive: Bool = true
  
  private var timer: AnyCancellable?
  public let correctOTP = "0000"
  
  var isOTPComplete: Bool {
    code.allSatisfy { $0.count == 1 }
  }

  func startTimer() {
    isTimerActive = true
    remainingTime = 15
    
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        if self.remainingTime > 0 {
          self.remainingTime -= 1
        } else {
          self.isTimerActive = false
          self.timer?.cancel()
        }
      }
  }
  
  func resetTimer() {
    startTimer()
  }
  
  func verifyOTP(correctOTP: String) -> Bool {
    let enteredOTP = code.joined()
    if enteredOTP == correctOTP {
      isError = false
      return true
    } else {
      isError = true
      return false
    }
  }
  
  func clearError() {
    isError = false
  }
}
