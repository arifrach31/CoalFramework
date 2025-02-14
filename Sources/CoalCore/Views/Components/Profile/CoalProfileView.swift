//
//  CoalProfileView.swift
//  Coal
//
//  Created by M. Rizki Maulana on 12/02/25.
//

import SwiftUI

public struct CoalProfileView: View {
  private let model: ProfileModel
  private let didSelectNotification: (() -> Void)?
  
  public init(
    model: ProfileModel,
    didSelectNotification: (() -> Void)? = nil
  ) {
    self.model = model
    self.didSelectNotification = didSelectNotification
  }
  
  public var body: some View {
    HStack(spacing: 12) {
      profileImage
      profileText
      
      Spacer()
      
      profileNotification
    }
    .padding()
  }
  
  private var profileImage: some View {
    CoalImageView(
      imageURL: model.image,
      width: model.imageSize,
      height: model.imageSize
    )
  }
  
  private var profileText: some View {
    VStack(alignment: .leading, spacing: 4) {
      VStack(alignment: .leading, spacing: 2) {
        Text(model.name)
          .font(.system(size: model.nameFontSize, weight: .semibold))
          .foregroundColor(model.nameColor)
        
        Text(model.role)
          .font(.system(size: model.roleFontSize))
          .foregroundColor(model.roleTextColor)
      }
      
      Text(model.time)
        .font(.system(size: model.timeFontSize))
        .foregroundColor(model.timeTextColor)
    }
  }
  
  private var profileNotification: some View {
    Group {
      ZStack(alignment: .topTrailing) {
        CoalImageView(
          imageURL: model.notificationImage,
          width: model.notificationImageSize,
          height: model.notificationImageSize,
          color: .black
        )
        
        ZStack {
          Circle()
            .fill(Color.red)
            .frame(width: 24, height: 24)
          
          Text("\(model.notificationCount)")
            .foregroundColor(.white)
            .font(.system(size: 12, weight: .bold))
        }
        .offset(x: 8, y: -8)
      }
      .onTapGesture {
        didSelectNotification?()
      }
    }
  }
}
