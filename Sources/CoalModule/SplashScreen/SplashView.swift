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
  
  public var body: some View {
    let (backgroundImage, backgroundColor) = config?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor
    ) {
      logo
    }.onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        navigator?.showInitialPage(isLoggedIn: false)
      }
    }
  }
  
  private var logo: some View {
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
}

#Preview {
  SplashView()
}
