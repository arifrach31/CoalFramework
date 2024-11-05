//
//  WebViewWrapper.swift
//  CoalFramework
//
//  Created by ArifRachman on 05/11/24.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
  @ObservedObject var viewModel: WebViewViewModel
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    
    if let urlString = viewModel.config?.url, let url = URL(string: urlString) {
      webView.load(URLRequest(url: url))
    }
    return webView
  }
  
  func updateUIView(_ uiView: WKWebView, context: Context) {
    if let urlString = viewModel.config?.url, let url = URL(string: urlString), uiView.url != url {
      uiView.load(URLRequest(url: url))
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(viewModel: viewModel)
  }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    var viewModel: WebViewViewModel
    
    init(viewModel: WebViewViewModel) {
      self.viewModel = viewModel
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      viewModel.updateLoadingState(isLoading: false, hasError: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
      viewModel.updateLoadingState(isLoading: false, hasError: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      viewModel.updateLoadingState(isLoading: true, hasError: false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      viewModel.updateLoadingState(isLoading: false, hasError: true)
    }
  }
}
