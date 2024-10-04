//
//  SplashscreenViewController.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import SwiftUI
import UIKit
import CoalCore

public class SplashscreenFactory {
  private static let defaultBackgroundColor: UIColor = .white
  
  public static func createSplashscreen(backgroundColor: UIColor? = nil, clientLogoName: UIImage? = nil) -> SplashscreenViewController {
    let logoImage = clientLogoName
    let backgroundColor = backgroundColor ?? defaultBackgroundColor
    return SplashscreenViewController(backgroundColor: backgroundColor, clientLogoName: logoImage)
  }
}

public class SplashscreenViewController: CoalViewController {
  
  private let logoImageView = UIImageView()
  
  public init(backgroundColor: UIColor, clientLogoName: UIImage?) {
    super.init(backgroundColor: backgroundColor, backgroundImage: UIImage.mainBackground)
    self.setupLogo(clientLogoName: clientLogoName)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLogo(clientLogoName: UIImage?) {
    logoImageView.image = clientLogoName
    logoImageView.contentMode = .scaleAspectFit
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(logoImageView)
    
    NSLayoutConstraint.activate([
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageView.heightAnchor.constraint(equalToConstant: 200)
    ])
  }
}
