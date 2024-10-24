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
  let additionalParam: String
  
  public init(
    configHeader: ConfigHeader? = nil,
    additionalParam: String = "",
    alignment: HorizontalAlignment = .leading
  ) {
    self.configHeader = configHeader
    self.alignment = alignment
    self.additionalParam = additionalParam
  }
  
  public var body: some View {
    VStack(alignment: alignment, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5(color: Color.blackText)
      
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular(color: Color.grayText)
      
      if !additionalParam.isEmpty {
        Text(additionalParam)
          .lgnBodySmallRegular(color: Color.grayText)
      }
    }
    .padding(.top, 20)
  }
}
