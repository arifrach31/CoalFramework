//
//  SplashView.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import SwiftUI
import CoalCore

public struct SplashView: View {
  public let config: SplashConfig?
  
  private var backgroundImage: Image {
    if let imageName = config?.backgroundImage, Image.exists(imageName) {
      return Image(imageName)
    }
    return Image.mainBackground
  }
  
  private var backgroundColor: Color {
    return Color(hex: config?.backgroundColor ?? "#000000")
  }
  
  private func loadLogo() -> some View {
    if let logoName = config?.logoImage {
      return AnyView(
        CoalImageView(imageURL: logoName, width: 200, height: 200)
      )
    } else {
      return AnyView(
        Text("Logo not available")
          .foregroundColor(.gray)
      )
    }
  }
  
  public init(config: SplashConfig? = nil) {
    self.config = config
  }
  
  public var body: some View {
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor,
      content: {
        loadLogo()
      }
    )
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
