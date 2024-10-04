//
//  CoalFramework.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import CoalCore

public protocol CoalConfigDelegate {
  func initCoalConfig() -> CoalConfig
}

public class CoalFramework {
  public static let shared = CoalFramework()
  
  private let networkManager: NetworkManager
  private let coalNavigator: CoalNavigator
  
  init(networkManager: NetworkManager = NetworkManager.shared, coalNavigator: CoalNavigator = CoalNavigator.shared) {
    self.networkManager = networkManager
    self.coalNavigator = coalNavigator
  }
  
  public func configure(
    windowScene: UIWindowScene?,
    backgroundColor: UIColor? = .white,
    logo: String? = nil,
    frameworkConfig: CoalConfig
  ) {
    configNavigator(windowScene: windowScene, from: frameworkConfig)
    fetchAndUpdateInitialConfig(backgroundColor: backgroundColor, configLogoName: logo)
  }
  
  private func fetchAndUpdateInitialConfig(backgroundColor: UIColor?, configLogoName: String?) {
    if let config = ConfigModel.currentConfig {
      updateConfig(with: config)
      showInitialScreen(backgroundColor: backgroundColor, configLogoName: configLogoName)
    } else {
      fetchConfig { [weak self] result in
        self?.handleConfigFetchResult(result, backgroundColor: backgroundColor, configLogoName: configLogoName)
      }
    }
  }
  
  private func fetchConfig(completion: @escaping (Result<ConfigModel, ApiError>) -> Void) {
    networkManager.request(endpoint: CoalAPI.getConfig, responseType: ConfigModel.self, completion: completion)
  }
  
  private func handleConfigFetchResult(_ result: Result<ConfigModel, ApiError>, backgroundColor: UIColor?, configLogoName: String?) {
    switch result {
    case .success(let config):
      updateConfig(with: config)
    case .failure(let error):
      handleFetchError(error)
    }
    showInitialScreen(backgroundColor: backgroundColor, configLogoName: configLogoName)
  }
  
  private func updateConfig(with config: ConfigModel) {
    config.save()
  }
  
  private func handleFetchError(_ error: ApiError) {
    print("Error fetching config: \(error.localizedDescription)")
  }
  
  private func showInitialScreen(backgroundColor: UIColor?, configLogoName: String?) {
    coalNavigator.showSplashScreen(backgroundColor: backgroundColor ?? .white, configLogoName: configLogoName)
  }
  
  private func configNavigator(windowScene: UIWindowScene?, from frameworkConfig: CoalConfig) {
    coalNavigator.windowScene = windowScene
    coalNavigator.homeConfig = frameworkConfig.homeConfig
    coalNavigator.loginConfig = frameworkConfig.loginConfig
    coalNavigator.registerConfig = frameworkConfig.registerConfig
  }
}
