//
//  CoalNavBar.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI

public enum PageType {
  case home
  case account
  case verificationMethod
  case verificationCode
  case other(String)
  
  var title: String? {
    switch self {
    case .account:
      return CoalString.account
    case .other(let customTitle):
      return customTitle
    case .verificationCode:
      return CoalString.accountVerification
    default:
      return nil
    }
  }
  
  var trailingIcon: Image? {
    switch self {
    case .home:
      return Image(systemName: "magnifyingglass")
    default:
      return nil
    }
  }
}

public struct CoalNavBar: View {
  var pageType: PageType
  var leadingAction: (() -> Void)?
  var trailingAction: (() -> Void)?
  
  public init(pageType: PageType,
              leadingAction: (() -> Void)? = nil,
              trailingAction: (() -> Void)? = nil) {
    self.pageType = pageType
    self.leadingAction = leadingAction
    self.trailingAction = trailingAction
  }
  
  public var body: some View {
    HStack {
      if let leadingAction = leadingAction {
        leadingButtonView(action: leadingAction)
      }
      
      Spacer()
      
      if let title = pageType.title {
        titleView(title: title)
      }
      
      Spacer()
      
      if let trailingAction = trailingAction, let trailingIcon = pageType.trailingIcon {
        trailingButtonView(action: trailingAction, icon: trailingIcon)
      }
    }
    .frame(height: 60)
    .background(.clear)
    .shadow(radius: 2)
  }
  
  private func leadingButtonView(action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Image(systemName: "arrow.left")
        .resizable()
        .frame(width: 24, height: 20)
        .font(.title)
        .foregroundColor(.white)
    }
    .frame(width: 44, height: 44)
    .padding(.leading, 10)
  }
  
  private func trailingButtonView(action: @escaping () -> Void, icon: Image) -> some View {
    Button(action: action) {
      icon
        .resizable()
        .frame(width: 24, height: 24)
        .padding()
        .foregroundColor(.black)
    }
  }
  
  private func titleView(title: String) -> some View {
    Text(title)
      .font(.headline)
      .foregroundColor(.white)
  }
}
