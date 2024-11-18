//
//  SplashView.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import SwiftUI
import CoalCore

public struct SplashView: View {
  @EnvironmentObject var config: CoalConfig
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    self.navigator = navigator
  }
  
  public var body: some View {
    let splashConfig = config.splashConfig
    let (backgroundImage, backgroundColor) = splashConfig?.getBackground() ?? (nil, nil)
    
    CoalBaseView(
      backgroundImage: backgroundImage,
      backgroundColor: backgroundColor
    ) {
      AnyView(logoView(for: splashConfig))
    }.onAppear {
      navigateToInitialPage(delay: splashConfig?.delay ?? 2.0)
    }
  }
  
  private func logoView(for splashConfig: SplashConfig?) -> any View {
    if let logoName = splashConfig?.logoImage {
      return CoalImageView(imageURL: logoName, width: 200, height: 200)
    } else if let defaultLogo = UIImage.coalLogo?.imageName {
      return CoalImageView(imageURL: defaultLogo, width: 200, height: 200)
    } else {
      return Text("Logo not available")
        .foregroundColor(.gray)
    }
  }
  
  private func navigateToInitialPage(delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      navigator?.showInitialPage(isLoggedIn: false)
    }
  }
}

#Preview {
  SplashView()
}
