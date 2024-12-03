//
//  WebViewModel.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/11/24.
//

import Foundation

public struct WebViewModel {
  public var title: String?
  public var url: String?
  
  public init(
    title: String? = nil,
    url: String? = nil
  ) {
    self.title = title
    self.url = url
  }
}
