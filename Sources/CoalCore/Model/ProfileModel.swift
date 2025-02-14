//
//  ProfileModel.swift
//  Coal
//
//  Created by M. Rizki Maulana on 12/02/25.
//

import SwiftUI

public struct ProfileModel {
  public var image: String
  public var name: String
  public var role: String
  public var time: String
  public var notificationImage: String
  public var notificationCount: Int
  public var imageSize: CGFloat
  public var nameColor: Color
  public var nameFontSize: CGFloat
  public var roleTextColor: Color
  public var roleFontSize: CGFloat
  public var timeTextColor: Color
  public var timeFontSize: CGFloat
  public var notificationImageSize: CGFloat
  public var notificationAction: ViewScreenType?
  
  public init(
    image: String = "",
    name: String = "",
    role: String = "",
    time: String = "",
    notificationImage: String = "",
    notificationCount: Int = 4,
    imageSize: CGFloat = 40,
    nameColor: Color = .black,
    nameFontSize: CGFloat = 20,
    roleTextColor: Color = .gray,
    roleFontSize: CGFloat = 16,
    timeTextColor: Color = .gray,
    timeFontSize: CGFloat = 14,
    notificationImageSize: CGFloat = 24,
    notificationAction: ViewScreenType? = nil
  ) {
    self.image = image
    self.name = name
    self.role = role
    self.time = time
    self.notificationImage = notificationImage
    self.notificationCount = notificationCount
    self.imageSize = imageSize
    self.nameColor = nameColor
    self.nameFontSize = nameFontSize
    self.roleTextColor = roleTextColor
    self.roleFontSize = roleFontSize
    self.timeTextColor = timeTextColor
    self.timeFontSize = timeFontSize
    self.notificationImageSize = notificationImageSize
    self.notificationAction = notificationAction
  }
}
