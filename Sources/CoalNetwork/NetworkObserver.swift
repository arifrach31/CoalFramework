//
//  NetworkObserver.swift
//  CoalFramework
//
//  Created by ArifRachman on 03/09/24.
//

import Network

protocol NetworkObserverDelegate: AnyObject {
  func networkStatusDidChange(status: NetworkStatus)
}

enum NetworkStatus {
  case connected(ConnectionType)
  case notConnected
  case poorConnection
}

enum ConnectionType {
  case wifi
  case cellular
  case ethernet
  case other
}

class NetworkObserver {
  
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue.global(qos: .background)
  weak var delegate: NetworkObserverDelegate?
  
  init() {
    monitor.pathUpdateHandler = { [weak self] path in
      self?.handleNetworkChange(path: path)
    }
    monitor.start(queue: queue)
  }
  
  deinit {
    monitor.cancel()
  }
  
  private func handleNetworkChange(path: NWPath) {
    if path.status == .satisfied {
      if path.isExpensive {
        delegate?.networkStatusDidChange(status: .poorConnection)
      } else {
        let connectionType = self.getConnectionType(path: path)
        delegate?.networkStatusDidChange(status: .connected(connectionType))
      }
    } else {
      delegate?.networkStatusDidChange(status: .notConnected)
    }
  }
  
  private func getConnectionType(path: NWPath) -> ConnectionType {
    if path.usesInterfaceType(.wifi) {
      return .wifi
    } else if path.usesInterfaceType(.cellular) {
      return .cellular
    } else if path.usesInterfaceType(.wiredEthernet) {
      return .ethernet
    } else {
      return .other
    }
  }
}
