//
//  Image.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/08/24.
//

import Foundation
import SwiftUI
import UIKit

public extension Image {
  static let logo = Image("imgLogo", bundle: .module)
  static let eyeOn = Image("icEyeOn", bundle: .module)
  static let eyeOff = Image("icEyeOff", bundle: .module)
  static let icInfo = Image(systemName: "info.circle")
  static let mainBackground = Image("imgBackground", bundle: .module)
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
