//
//  CoalConfig.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import CoalNetwork
import CoalModel

public protocol Config {
  func configure(window: UIWindow?, backgroundColor: UIColor?, logo: String?)
}

public class CoalConfig: Config {
  public static let shared = CoalConfig()
  
  private let networkManager: NetworkManager
  private let coalNavigator: CoalNavigator
  
  init(networkManager: NetworkManager = NetworkManager.shared, coalNavigator: CoalNavigator = CoalNavigator.shared) {
    self.networkManager = networkManager
    self.coalNavigator = coalNavigator
  }
  
  public func configure(window: UIWindow?, backgroundColor: UIColor? = .white, logo: String? = nil) {
    coalNavigator.window = window
    
    if let config = ConfigModel.currentConfig {
      updateConfig(with: config)
      showInitialScreen(backgroundColor: backgroundColor, configLogoName: logo)
    } else {
      fetchConfig { [weak self] result in
        switch result {
        case .success(let config):
          self?.updateConfig(with: config)
        case .failure(let error):
          self?.handleFetchError(error)
        }
        
        self?.showInitialScreen(backgroundColor: backgroundColor, configLogoName: logo)
      }
    }
  }
  
  private func fetchConfig(completion: @escaping (Result<ConfigModel, ApiError>) -> Void) {
    networkManager.request(endpoint: CoalAPI.getConfig, responseType: ConfigModel.self, completion: completion)
  }
  
  private func updateConfig(with config: ConfigModel) {
    config.save()
  }
  
  private func handleFetchError(_ error: ApiError) {
    print("Error: \(error.localizedDescription)")
  }
  
  private func showInitialScreen(backgroundColor: UIColor?, configLogoName: String?) {
    coalNavigator.showSplashScreen(backgroundColor: backgroundColor ?? .white, configLogoName: configLogoName)
  }
}
