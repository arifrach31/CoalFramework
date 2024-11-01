//
//  NetworkProvider.swift
//  CoalClient
//
//  Created by ArifRachman on 23/10/24.
//

import CoalCore

class NetworkProvider: NetworkConfigProvider {
  func getConfig() -> CoalCore.NetworkConfig {
    NetworkConfig(baseURL: "https://y22y4.wiremockapi.cloud")
  }
}
