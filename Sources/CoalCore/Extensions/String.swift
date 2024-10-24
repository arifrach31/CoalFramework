//
//  String.swift
//
//
//  Created by ArifRachman on 23/09/24.
//

import Foundation
import CommonCrypto

public extension String {
  var isValidURL: Bool {
    if let url = URL(string: self) {
      return url.scheme == "http" || url.scheme == "https"
    }
    return false
  }
  
  func hmac(algorithm: HMACAlgorithm, key: String) -> String {
    if let cKey = key.cString(using: .utf8), let cData = self.cString(using: .utf8) {
      var result = [CUnsignedChar](repeating: 0, count: algorithm.digestLength())
      CCHmac(algorithm.toCCHmacAlgorithm(), cKey, strlen(cKey), cData, strlen(cData), &result)
      let hmacData = Data(bytes: result, count: algorithm.digestLength())
      let hmacBase64 = hmacData.base64EncodedString(options: .lineLength64Characters)
      return hmacBase64
    }
    return ""
  }
  
  func encrypt(key: String = RandomStringItem().getEncryptionKey(), ivString: String = RandomStringItem().getEncryptionIv(), options: Int = kCCOptionPKCS7Padding) -> String {
    if let keyData = key.data(using: .utf8),
       let data = self.data(using: .utf8),
       let cryptData = NSMutableData(length: data.count + kCCBlockSizeAES128) {
      
      let keyLength = size_t(kCCKeySizeAES128)
      let operation: CCOperation = UInt32(kCCEncrypt)
      let algorithm: CCAlgorithm = UInt32(kCCAlgorithmAES128)
      let options: CCOptions = UInt32(options)
      
      var numBytesEncrypted: size_t = 0
      let cryptStatus = CCCrypt(operation,
                                algorithm,
                                options,
                                keyData.withUnsafeBytes { $0.baseAddress }, keyLength,
                                ivString,
                                data.withUnsafeBytes { $0.baseAddress }, data.count,
                                cryptData.mutableBytes, cryptData.length,
                                &numBytesEncrypted)
      
      if UInt32(cryptStatus) == UInt32(kCCSuccess) {
        cryptData.length = Int(numBytesEncrypted)
        let base64cryptString = cryptData.base64EncodedString(options: .lineLength64Characters)
        return base64cryptString
      } else {
        return self
      }
    }
    return self
  }
  
  func decrypt(key: String = RandomStringItem().getEncryptionKey(), ivString: String = RandomStringItem().getEncryptionIv(), options: Int = kCCOptionPKCS7Padding) -> String {
    if let keyData = key.data(using: .utf8),
       let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters),
       let cryptData = NSMutableData(length: data.count + kCCBlockSizeAES128) {
      
      let keyLength = size_t(kCCKeySizeAES128)
      let operation: CCOperation = UInt32(kCCDecrypt)
      let algorithm: CCAlgorithm = UInt32(kCCAlgorithmAES128)
      let options: CCOptions = UInt32(options)
      
      var numBytesEncrypted: size_t = 0
      let cryptStatus = CCCrypt(operation,
                                algorithm,
                                options,
                                keyData.withUnsafeBytes { $0.baseAddress }, keyLength,
                                ivString,
                                data.withUnsafeBytes { $0.baseAddress }, data.count,
                                cryptData.mutableBytes, cryptData.length,
                                &numBytesEncrypted)
      
      if UInt32(cryptStatus) == UInt32(kCCSuccess) {
        cryptData.length = Int(numBytesEncrypted)
        let unencryptedMessage = String(data: cryptData as Data, encoding: .utf8)
        return unencryptedMessage ?? self
      } else {
        return self
      }
    }
    return self
  }
}

public enum HMACAlgorithm {
  case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
  
  public func toCCHmacAlgorithm() -> CCHmacAlgorithm {
    switch self {
    case .MD5:
      return CCHmacAlgorithm(kCCHmacAlgMD5)
    case .SHA1:
      return CCHmacAlgorithm(kCCHmacAlgSHA1)
    case .SHA224:
      return CCHmacAlgorithm(kCCHmacAlgSHA224)
    case .SHA256:
      return CCHmacAlgorithm(kCCHmacAlgSHA256)
    case .SHA384:
      return CCHmacAlgorithm(kCCHmacAlgSHA384)
    case .SHA512:
      return CCHmacAlgorithm(kCCHmacAlgSHA512)
    }
  }
  
  public func digestLength() -> Int {
    switch self {
    case .MD5:
      return Int(CC_MD5_DIGEST_LENGTH)
    case .SHA1:
      return Int(CC_SHA1_DIGEST_LENGTH)
    case .SHA224:
      return Int(CC_SHA224_DIGEST_LENGTH)
    case .SHA256:
      return Int(CC_SHA256_DIGEST_LENGTH)
    case .SHA384:
      return Int(CC_SHA384_DIGEST_LENGTH)
    case .SHA512:
      return Int(CC_SHA512_DIGEST_LENGTH)
    }
  }
}

public class RandomStringItem {
  public static let characters = Array("12345789")
  public static let length = UInt32(characters.count)
  
  public let encryptionKey = "bEDytW8VGZky1RPSNdZ5UyxxO+SLp1m4BnE9nPEASHQ="
  public let encryptionIv = "QeaRw4VG4RbY95oe+3/gEHb3SpsKPrLUh/5Ciik73zc="
  
  public init() {}
  
  public func getEncryptionKey() -> String {
    return encryptionKey.decrypt(key: "jKe3Ang4ShimWc9a", ivString: "pDjj8Scgh1hfgki4")
  }
  
  public func getEncryptionIv() -> String {
    return encryptionIv.decrypt(key: "jKe3Ang4ShimWc9a", ivString: "pDjj8Scgh1hfgki4")
  }
}
