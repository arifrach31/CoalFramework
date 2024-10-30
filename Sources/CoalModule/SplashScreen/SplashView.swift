//
//  SplashView.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import SwiftUI
import CoalCore

public struct SplashView: View {
  public var navigator: CoalNavigatorProtocol?
  public let config: SplashConfig?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: SplashConfig? = nil) {
    self.navigator = navigator
    self.config = config
  }
  
  private var backgroundImage: Image? {
    if let imageName = config?.backgroundImageName, Image.exists(imageName) {
      return Image(imageName)
    } else if config?.backgroundColor == nil {
      return Image.mainBackground
    }
    return nil
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
    ).onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        navigator?.showInitialPage(isLoggedIn: false)
      }
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
