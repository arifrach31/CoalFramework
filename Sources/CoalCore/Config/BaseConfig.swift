//
//  BaseConfig.swift
//
//
//  Created by ArifRachman on 15/10/24.
//

import SwiftUI

public class BaseConfig {
  public var backgroundImage: String?
  public var backgroundColor: String?
  
  public init(backgroundImage: String? = nil, backgroundColor: String? = nil) {
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
  }
}

extension BaseConfig {
  public func getBackground() -> (Image, Color) {
    let backgroundImage = backgroundImage ?? ""
    let backgroundColorHex = backgroundColor ?? ""
    
    let backgroundName: Image = backgroundImage.isEmpty ? Image.mainBackground : Image(backgroundImage)
    let backgroundColor: Color = backgroundColorHex.isEmpty ? Color.white : Color(hex: backgroundColorHex)
    
    return (backgroundName, backgroundColor)
  }
}
