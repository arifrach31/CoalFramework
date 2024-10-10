//
//  CoalFramework.swift
//  CoalFramework
//
//  Created by ArifRachman on 08/08/24.
//

import UIKit
import CoalCore

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
    frameworkConfig: CoalConfig?
  ) {
    configNavigator(windowScene: windowScene, from: frameworkConfig)
    fetchAndUpdateInitialConfig()
  }
  
  private func fetchAndUpdateInitialConfig() {
    if let config = ConfigModel.currentConfig {
      updateConfig(with: config)
      showInitialScreen()
    } else {
      fetchConfig { [weak self] result in
        self?.handleConfigFetchResult(result)
      }
    }
  }
  
  private func fetchConfig(completion: @escaping (Result<ConfigModel, ApiError>) -> Void) {
    networkManager.request(endpoint: CoalAPI.getConfig, responseType: ConfigModel.self, completion: completion)
  }
  
  private func handleConfigFetchResult(_ result: Result<ConfigModel, ApiError>) {
    switch result {
    case .success(let config):
      updateConfig(with: config)
    case .failure(let error):
      handleFetchError(error)
    }
    showInitialScreen()
  }
  
  private func updateConfig(with config: ConfigModel) {
    config.save()
  }
  
  private func handleFetchError(_ error: ApiError) {
    print("Error fetching config: \(error.localizedDescription)")
  }
  
  private func showInitialScreen() {
    coalNavigator.showSplashScreen()
  }
  
  private func configNavigator(windowScene: UIWindowScene?, from frameworkConfig: CoalConfig?) {
    coalNavigator.windowScene = windowScene
    coalNavigator.setViewConfig(frameworkConfig)
  }
}
