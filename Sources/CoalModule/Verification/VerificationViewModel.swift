//
//  VerificationViewModel.swift
//
//
//  Created by ArifRachman on 18/10/24.
//

import SwiftUI
import Combine
import CoalCore

public class VerificationViewModel: ObservableObject {
  @Published var code: [String] = Array(repeating: "", count: 4)
  @Published var isError: Bool = false
  @Published var remainingTime: Int = 15
  @Published var isTimerActive: Bool = true
  @Published var isLoading: Bool = false
  
  private var timer: AnyCancellable?
  public let correctOTP = "0000"
  public var sendTo: [ConfigField]?
  
  var isOTPComplete: Bool {
    code.allSatisfy { $0.count == 1 }
  }
  
  init() {
    setupSendTo()
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
  
  private func setupSendTo() {
    guard let currentUser = CoalUser.currentUser,
          let userData = currentUser.data else {
      sendTo = []
      return
    }
    
    sendTo = [
      ConfigField(type: .email, label: userData.email ?? "-"),
      ConfigField(type: .phone, label: userData.phoneNumber ?? "-")
    ]
  }
  
  func sendOTP(method: ConfigField, completion: @escaping (Result<Void, ApiError>) -> Void) {
    guard let sendTo = method.label else {
      completion(.failure(.connectionError))
      return
    }
    
    let channel = method.type?.rawValue ?? ""
//    let nonce = UUID().uuidString
//    let timestamp = "\(Int(Date().timeIntervalSince1970))"
//    let signatureInput = "\(timestamp)\(nonce)\(channel)"
//    let signature = signatureInput.hmac(algorithm: .SHA256, key: Config.hmac256Key.decrypt())
    
    isLoading = true
    
    NetworkManager.shared.request(
      endpoint: .sendOTP(
        channel: channel,
        sendTo: sendTo,
        timeStamp: "1591752712",
        nonce: "asdasdaseqweqwe",
        signature: "wINJIP3ZVMDlYQIJJZ1bgk9xkc8chLWY59Dj512LyaE="
      ),
      responseType: BaseResponseModel<UserData>.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success:
          completion(.success(()))
        case .failure(let error):
          self?.isError = true
          completion(.failure(error))
        }
      }
    }
  }
}
