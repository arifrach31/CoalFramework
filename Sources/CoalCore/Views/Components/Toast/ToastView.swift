//
//  ToastView.swift
//
//
//  Created by ArifRachman on 23/10/24.
//

import SwiftUI

public struct ToastView: View {
  @Binding var isVisible: Bool
  var message: String
  
  public var body: some View {
    if isVisible {
      Text(message)
        .padding()
        .background(Color.black.opacity(0.7))
        .foregroundColor(.white)
        .cornerRadius(8)
        .padding(.horizontal)
        .transition(.slide)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
              isVisible = false
            }
          }
        }
    }
  }
}

