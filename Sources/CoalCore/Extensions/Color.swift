//
//  Color.swift
//  CoalFramework
//
//  Created by ArifRachman on 06/09/24.
//

import SwiftUI

public extension Color {
  static let mainBackground = Color(hex: "#0D0D1B")
  static let redButton      = Color(hex: "#E42313")
}

public extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >> 8) & 0xFF) / 255.0
    let b = Double(rgb & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
