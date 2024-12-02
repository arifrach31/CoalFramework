//
//  FormHeaderView.swift
//
//
//  Created by ArifRachman on 16/10/24.
//

import SwiftUI
import LegionUI
import ThemeLGN

public struct FormHeaderView: View {
  private let configHeader: ConfigHeader?
  private let alignment: HorizontalAlignment
  private let additionalText: String
  
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
      headerTitle
      headerDescription
      additionalInfo
    }
    .padding(.top, 20)
  }
  
  private var headerTitle: some View {
    Text(configHeader?.title ?? CoalString.loginTitle)
      .lgnHeading5(color: Color.blackText)
  }
  
  private var headerDescription: some View {
    Text(configHeader?.description ?? CoalString.loginDescription)
      .lgnBodySmallRegular(color: LGNColor.tertiary500)
  }
  
  @ViewBuilder
  private var additionalInfo: some View {
    if !additionalText.isEmpty {
      Text(additionalText)
        .lgnBodySmallRegular(color: LGNColor.tertiary500)
    }
  }
}
