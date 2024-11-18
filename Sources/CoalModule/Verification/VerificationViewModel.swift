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
  public var config: VerificationConfig?
  public var sendTo: [ConfigField]? {
    didSet {
      objectWillChange.send()
    }
  }
  
  var buttonVerifyCode: ConfigField {
    config?.verificationCodeFields?.buttonVerificationCode ?? ConfigField(
      type: .submit,
      label: CoalString.verify
    )
  }
  
  var isOTPComplete: Bool {
    code.allSatisfy { $0.count == 1 }
  }
  
  func configure(with config: VerificationConfig?) {
    self.config = config
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
  
  func sendOTP(method: ConfigField, completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
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
  
  func getSendToMasking(methodField: ConfigField?) -> String {
    if let showMethod = config?.showVerificationMethod,
       showMethod == false {
      let sendVerificationTo = config?.verificationCodeFields?.sendVerificationCodeTo
      return maskingField(sendVerificationTo?.label ?? "", type: (sendVerificationTo?.type ?? .email))
    } else {
      return maskingField((methodField?.label ?? config?.verificationCodeFields?.sendVerificationCodeTo?.label) ?? "", type: methodField?.type ?? .email)
    }
  }
  
  func verifyOTP(sendTo: String?, completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
    guard let sendTo = sendTo else {
      completion(.failure(.connectionError))
      return
    }
    
    let enteredOTP = code.joined()
    isLoading = true
    
    NetworkManager.shared.request(
      endpoint: .verifyOTP(
        sendTo: sendTo,
        otp: enteredOTP
      ),
      responseType: BaseResponseModel<VerificationModel>.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success:
          self?.isError = false
          completion(.success(()))
        case .failure(let error):
          self?.isError = true
          completion(.failure(error))
        }
      }
    }
  }
  
  func verifyPassword(email: String?, completion: @escaping (Result<Void, ApiErrorType>) -> Void) {
    guard let email = email else {
      completion(.failure(.connectionError))
      return
    }
    
    let enteredOTP = code.joined()
    isLoading = true
    NetworkManager.shared.request(
      endpoint: .verifyForgotPassword(email: email, code: enteredOTP),
      responseType: BaseResponseModel<VerificationModel>.self
    ) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading = false
        switch result {
        case .success:
          self?.isError = false
          completion(.success(()))
        case .failure(let error):
          self?.isError = true
          completion(.failure(error))
        }
      }
    }
  }
}
