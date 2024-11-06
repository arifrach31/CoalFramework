//
//  CoalBaseView.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/09/24.
//

import SwiftUI

public struct CoalBaseView<Content: View>: View {
  private let pageType: PageType?
  private let leftAction: (() -> Void)?
  private let rightAction: (() -> Void)?
  private let backgroundImage: Image?
  private let backgroundColor: Color?
  private let content: Content
  private let isShowNavBar: Bool
  private let isLoading: Bool
  private let bottomSheetContent: AnyView?
  
  @State private var toastData: ToastModel?
  @State private var isToastVisible: Bool = false
  @StateObject private var toastManager = ToastManager()
  @Binding private var isShowingBottomSheet: Bool
  
  public init(
    pageType: PageType? = nil,
    leftAction: (() -> Void)? = nil,
    rightAction: (() -> Void)? = nil,
    backgroundImage: Image? = nil,
    backgroundColor: Color? = .white,
    isShowNavBar: Bool = true,
    isLoading: Bool = false,
    isShowingBottomSheet: Binding<Bool> = .constant(false),
    bottomSheetContent: AnyView? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.pageType = pageType
    self.leftAction = leftAction
    self.rightAction = rightAction
    self.backgroundImage = backgroundImage
    self.backgroundColor = backgroundColor
    self.isShowNavBar = isShowNavBar
    self.isLoading = isLoading
    self._isShowingBottomSheet = isShowingBottomSheet
    self.bottomSheetContent = bottomSheetContent
    self.content = content()
  }
  
  public var body: some View {
    ZStack {
      if let image = backgroundImage {
        image
          .resizable()
          .edgesIgnoringSafeArea(.all)
      } else {
        if backgroundColor == nil {
          Image.mainBackground
            .resizable()
            .edgesIgnoringSafeArea(.all)
        } else {
          backgroundColor.edgesIgnoringSafeArea(.all)
        }
      }
      
      VStack {
        if isShowNavBar, let pageType = pageType {
          CoalNavBar(
            pageType: pageType,
            leadingAction: leftAction,
            trailingAction: rightAction
          )
        }
        content
          .environmentObject(toastManager)
      }.blur(radius: (isLoading || isShowingBottomSheet) ? 3 : 0)
      
      if isLoading || isShowingBottomSheet {
        Color.black.opacity(0.6)
          .edgesIgnoringSafeArea(.all)
      }
      
      if isLoading {
        ProgressView()
          .scaleEffect(1.5)
      }
      
      if let toast = toastManager.toastData {
        ToastView(
          isVisible: $toastManager.isVisible,
          title: toast.title,
          subTitle: toast.subtitle,
          isError: toast.isError
        )
        .padding(.top, 50)
      }
      
      if isShowingBottomSheet,
          let bottomSheetContent = bottomSheetContent {
        VStack {
          Spacer()
          BottomSheetView(isShowing: $isShowingBottomSheet, dragable: true) {
            bottomSheetContent
          }
        }
      }
    }
    .navigationBarHidden(true)
    .onChange(of: toastManager.isVisible) { newValue in
      if !newValue {
        toastManager.hide()
      }
    }
  }
}
