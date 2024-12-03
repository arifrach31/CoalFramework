//
//  ToastModel.swift
//
//
//  Created by M. Rizki Maulana on 05/11/24.
//

import Foundation

public enum ToastType {
  case registerSuccess
  case registerFailure
  case resetPasswordSuccess
  case genericError
  case custom(title: String, subtitle: String, isError: Bool)
  
  public func getToastModel() -> ToastModel {
    switch self {
    case .registerSuccess:
      return ToastModel(
        title: CoalString.registerSuccessTitle,
        subtitle: CoalString.registerSuccessSubtitle,
        isError: false
      )
    case .registerFailure:
      return ToastModel(
        title: CoalString.registerFailureTitle,
        subtitle: CoalString.registerFailureSubtitle,
        isError: true
      )
    case .resetPasswordSuccess:
      return ToastModel(
        title: CoalString.resetPasswordSuccessTitle,
        subtitle: CoalString.resetPasswordSuccessSubtitle,
        isError: false
      )
    case .genericError:
      return ToastModel(
        title: CoalString.errorTitle,
        subtitle: CoalString.errorSubtitle,
        isError: true
      )
    case .custom(let title, let subtitle, let isError):
      return ToastModel(
        title: title,
        subtitle: subtitle,
        isError: isError
      )
    }
  }
}

public struct ToastModel {
  public var id: UUID?
  public var title: String?
  public var subtitle: String?
  public var isError: Bool
  
  public init(
    title: String? = "",
    subtitle: String? = "",
    isError: Bool = false
  ) {
    self.id = UUID()
    self.title = title
    self.subtitle = subtitle
    self.isError = isError
  }
}
