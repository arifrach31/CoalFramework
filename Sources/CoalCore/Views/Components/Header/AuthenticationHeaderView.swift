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
  let additionalText: String
  
  public init(
    configHeader: ConfigHeader? = nil,
    additionalText: String = "",
    alignment: HorizontalAlignment = .leading
  ) {
    self.configHeader = configHeader
    self.alignment = alignment
    self.additionalText = additionalText
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5(color: Color.blackText)
      
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular(color: LGNColor.tertiary500)
        .multilineTextAlignment(alignment == .center ? .center : (alignment == .trailing ? .trailing : .leading))
      
      if !additionalText.isEmpty {
        Text(additionalText)
          .lgnBodySmallRegular(color: LGNColor.tertiary500)
      }
    }
    .padding(.top, 20)
  }
}
