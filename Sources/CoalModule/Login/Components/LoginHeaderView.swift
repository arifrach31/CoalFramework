//
//  LoginHeaderView.swift
//
//
//  Created by ArifRachman on 16/10/24.
//

import SwiftUI
import CoalCore
import LegionUI
import ThemeLGN

public struct LoginHeaderView: View {
  let configHeader: ConfigHeader?
  
  public init(configHeader: ConfigHeader?) {
    self.configHeader = configHeader
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(configHeader?.title ?? CoalString.loginTitle)
        .lgnHeading5()
      Text(configHeader?.description ?? CoalString.loginDescription)
        .lgnBodySmallRegular()
    }
    .padding(.top, 20)
  }
}
