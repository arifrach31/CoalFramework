//
//  AuthenticationHeaderView.swift
//
//
//  Created by ArifRachman on 16/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct AuthenticationHeaderView: View {
  let configHeader: ConfigHeader?
  let alignment: HorizontalAlignment
  
  public init(configHeader: ConfigHeader?, alignment: HorizontalAlignment = .leading) {
    self.configHeader = configHeader
    self.alignment = alignment
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}
