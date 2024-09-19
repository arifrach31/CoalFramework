//
//  HomeView.swift
//  CoalFramework
//
//  Created by ArifRachman on 13/09/24.
//

import SwiftUI
import CoalModel
import CoalView

public struct HomeView: View {
  @StateObject private var viewModel: HomeViewModel
  private let clientLogoName: String?
  private let backgroundColor: Color
  
  public init(config: ConfigModel? = nil, clientLogoName: String? = nil, backgroundColor: Color = .white) {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
    self.clientLogoName = clientLogoName
    self.backgroundColor = backgroundColor
  }
  
  public var body: some View {
    CoalBaseView(backgroundImage: Image.mainBackground, backgroundColor: backgroundColor) {
      VStack(spacing: 40) {
        Text("Home")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        if let clientLogoName = clientLogoName {
          Image(clientLogoName)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
        }
        
        Text("Welcome to the Home View")
          .font(.body)
          .foregroundColor(.gray)
      }
      .padding()
    }
  }
}
