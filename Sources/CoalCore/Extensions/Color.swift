//
//  Color.swift
//  CoalFramework
//
//  Created by ArifRachman on 06/09/24.
//

import SwiftUI

public extension Color {
  static let mainBackground       = Color(hex: "#0D0D1B")
  static let secondaryBackground  = Color(hex: "#F9FAFB")
  static let redButton            = Color(hex: "#E42313")
  static let blackText            = Color(hex: "#212121")
  static let grayBorder           = Color(hex: "#D0D5DD")
  static let redBorder            = Color(hex: "#F04438")
}

public extension Color {
  func toHex() -> String? {
    if let components = UIColor(self).cgColor.components {
      let r = components[0]
      let g = components[1]
      let b = components[2]
      return String(format: "#%02lX%02lX%02lX", lround(Double(r * 255)), lround(Double(g * 255)), lround(Double(b * 255)))
    }
    return nil
  }
  
  init(hex: String) {
    var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
    
    let scanner = Scanner(string: hex)
    var hexNumber: UInt64 = 0
    
    let r, g, b, a: Double
    if scanner.scanHexInt64(&hexNumber) {
      switch hex.count {
      case 6:
        r = Double((hexNumber & 0xFF0000) >> 16) / 255
        g = Double((hexNumber & 0x00FF00) >> 8) / 255
        b = Double(hexNumber & 0x0000FF) / 255
        a = 1.0
      case 8:
        r = Double((hexNumber & 0xFF000000) >> 24) / 255
        g = Double((hexNumber & 0x00FF0000) >> 16) / 255
        b = Double((hexNumber & 0x0000FF00) >> 8) / 255
        a = Double(hexNumber & 0x000000FF) / 255
      default:
        r = 1.0; g = 1.0; b = 1.0; a = 1.0
      }
    } else {
      r = 1.0; g = 1.0; b = 1.0; a = 1.0
    }
    
    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
  }
}
