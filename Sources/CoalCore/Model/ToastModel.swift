//
//  ToastModel.swift
//
//
//  Created by M. Rizki Maulana on 05/11/24.
//

import Foundation

public struct ToastModel {
  public var id: UUID
  public var title: String
  public var subtitle: String
  public var isError: Bool
  
  public init(title: String, subtitle: String, isError: Bool = false) {
    self.id = UUID()
    self.title = title
    self.subtitle = subtitle
    self.isError = isError
  }
}
