//
//  CoalBaseView.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/09/24.
//

import SwiftUI

public struct CoalBaseView<Content: View>: View {
  private let backgroundImage: Image?
  private let backgroundColor: Color
  private let content: Content
  
  public init(backgroundImage: Image? = nil, backgroundColor: Color = .white, @ViewBuilder content: () -> Content) {
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
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
      
      content
    }
  }
}
