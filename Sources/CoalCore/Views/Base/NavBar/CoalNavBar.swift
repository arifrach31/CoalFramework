//
//  CoalNavBar.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI
import ThemeLGN
import LegionUI

public enum PageType {
  case home
  case account
  case verificationMethod
  case verificationCode
  case back
  case web(String)
  case other(String)
  
  var title: String? {
    switch self {
    case .account:
      return CoalString.account
    case .other(let customTitle),
        .web(let customTitle):
      return customTitle
    case .verificationCode:
      return CoalString.accountVerification
    case .verificationMethod:
      return CoalString.verification
    default:
      return nil
    }
  }
  
  var trailingIcon: Image? {
    switch self {
    case .home:
      return Image.magnifyingIcon
    default:
      return nil
    }
  }
  
  var tintColor: Color {
    switch self {
    case .web:
      return .black
    default:
      return .white
    }
  }
}

public struct CoalNavBar: View {
  private let pageType: PageType
  private let leadingAction: (() -> Void)?
  private let trailingAction: (() -> Void)?
  
  public init(
    pageType: PageType,
    leadingAction: (() -> Void)? = nil,
    trailingAction: (() -> Void)? = nil
  ) {
    self.pageType = pageType
    self.leadingAction = leadingAction
    self.trailingAction = trailingAction
  }
  
  public var body: some View {
    HStack {
      leadingButton
      titleText
      Spacer()
      trailingButton
    }
    .padding(.horizontal, 4)
    .frame(height: 60)
    .background(.clear)
  }
  
  @ViewBuilder
  private var leadingButton: some View {
    if let action = leadingAction {
      Button(action: action) {
        Image.arrowLeftIcon
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .padding(12)
          .foregroundColor(pageType.tintColor)
      }
    }
  }
  
  @ViewBuilder
  private var trailingButton: some View {
    if let action = trailingAction,
       let icon = pageType.trailingIcon {
      Button(action: action) {
        icon
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .padding()
          .foregroundColor(.black)
      }
    }
  }
  
  @ViewBuilder
  private var titleText: some View {
    if let title = pageType.title {
      Text(title)
        .lgnHeading5(color: pageType.tintColor)
    }
  }
}
