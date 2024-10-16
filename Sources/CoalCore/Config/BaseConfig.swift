//
//  BaseConfig.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import Foundation
import SwiftUI

public class BaseConfig {
  public var backgroundImageName: String?
  public var backgroundColor: String?
  
  public init(backgroundImageName: String? = nil, backgroundColor: String? = nil) {
    self.backgroundImageName = backgroundImageName
    self.backgroundColor = backgroundColor
  }
}

extension BaseConfig {
  public func getBackground() -> (Image, Color) {
    let backgroundImageName = backgroundImageName ?? ""
    let backgroundColorHex = backgroundColor ?? ""
    
    let backgroundImage: Image = backgroundImageName.isEmpty ? Image.mainBackground : Image(backgroundImageName)
    let backgroundColor: Color = backgroundColorHex.isEmpty ? Color.white : Color(hex: backgroundColorHex)
    
    return (backgroundImage, backgroundColor)
  }
}
