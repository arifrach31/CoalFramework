//
//  Image.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/08/24.
//

import SwiftUI
import UIKit

public extension Image {
  static let defaultLogo = Image("imgLogo", bundle: .module)
  static let eyeOn = Image("icEyeOn", bundle: .module)
  static let eyeOff = Image("icEyeOff", bundle: .module)
  static let mainBackground = Image("imgBackground", bundle: .module)
  
  static let emailIcon = Image(systemName: "envelope")
  static let smsIcon = Image(systemName: "ellipsis.bubble")
  static let waIcon = Image(systemName: "phone.bubble")
  static let unknownIcon = Image(systemName: "questionmark.circle")
  static let magnifyingIcon = Image(systemName: "magnifyingglass")
  static let arrowLeftIcon = Image(systemName: "arrow.left")
  static let warningIcon = Image(systemName: "exclamationmark.triangle")
}

public extension Image {
  func resized(to size: CGSize) -> some View {
    self
      .resizable()
      .frame(width: size.width, height: size.height)
  }
  
  static func exists(_ imageName: String) -> Bool {
    return UIImage(named: imageName) != nil
  }
}
