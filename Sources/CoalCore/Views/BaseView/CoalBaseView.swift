//
//  CoalBaseView.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/09/24.
//

import SwiftUI

public struct CoalBaseView<Content: View>: View {
  private let pageType: PageType?
  private let leftAction: (() -> Void)?
  private let rightAction: (() -> Void)?
  private let backgroundImage: Image?
  private let backgroundColor: Color
  private let content: Content
  private let isShowNavBar: Bool
  
  public init(
    pageType: PageType? = nil,
    leftAction: (() -> Void)? = nil,
    rightAction: (() -> Void)? = nil,
    backgroundImage: Image? = nil,
    backgroundColor: Color = .white,
    isShowNavBar: Bool = true,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.pageType = pageType
    self.leftAction = leftAction
    self.rightAction = rightAction
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
    self.isShowNavBar = isShowNavBar
    self.content = content()
  }
  
  public var body: some View {
    ZStack {
      if let image = backgroundImage {
        image
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
      } else {
        backgroundColor.edgesIgnoringSafeArea(.all)
      }
      
      VStack {
        if isShowNavBar, let pageType = pageType {
          CoalNavBar(
            pageType: pageType,
            leadingAction: leftAction,
            trailingAction: rightAction
          )
        }
        content
      }
    }
    .navigationBarHidden(true)
  }
}
