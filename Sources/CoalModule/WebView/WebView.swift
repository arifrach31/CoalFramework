//
//  WebView.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/11/24.
//

import SwiftUI
import CoalCore

public struct WebView: View {
  @StateObject private var viewModel: WebViewViewModel
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil, config: WebViewModel? = nil) {
    _viewModel = StateObject(wrappedValue: WebViewViewModel(config: config))
    self.navigator = navigator
  }
  
  public var body: some View {
    CoalBaseView(
      pageType: .web(viewModel.config?.title ?? ""),
      leftAction: { navigator?.popToPreviousView() },
      isShowNavBar: true,
      isLoading: viewModel.isLoading) {
        WebViewWrapper(viewModel: viewModel)
          .opacity(viewModel.isLoading || viewModel.hasError ? 0 : 1)
        
        if viewModel.hasError {
          Button("Retry") {
            viewModel.retryLoading()
          }
          Spacer()
        }
      }
  }
}

#Preview {
  WebView()
}
