//
//  CoalBaseView.swift
//  CoalFramework
//
//  Created by ArifRachman on 12/09/24.
//

import SwiftUI

public struct CoalBaseView<Content: View>: View {
  @EnvironmentObject private var coalEnvironment: CoalEnvironment
  @State private var isToastVisible: Bool = false
  @State private var toastModel: ToastModel = ToastModel()
  @Binding private var isShowingBottomSheet: Bool
  
  private let pageType: PageType?
  private let leftAction: (() -> Void)?
  private let rightAction: (() -> Void)?
  private let backgroundImage: Image?
  private let backgroundColor: Color?
  private let content: Content
  private let isShowNavBar: Bool
  private let isLoading: Bool
  private let isScrollView: Bool
  private let bottomSheetContent: any View
  
  public init(
    pageType: PageType? = nil,
    leftAction: (() -> Void)? = nil,
    rightAction: (() -> Void)? = nil,
    backgroundImage: Image? = nil,
    backgroundColor: Color? = .white,
    isShowNavBar: Bool = true,
    isLoading: Bool = false,
    isShowingBottomSheet: Binding<Bool> = .constant(false),
    isScrollView: Bool = false,
    bottomSheetContent: any View = EmptyView(),
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
    self.isScrollView = isScrollView
    self.bottomSheetContent = bottomSheetContent
    self.content = content()
  }
  
  public var body: some View {
    ZStack {
      backgroundView
      VStack {
        navbarView
        contentView
      }
      .blur(radius: (isLoading || isShowingBottomSheet) ? 3 : 0)
      loadingOverlay
      bottomSheetView
      toastView
    }
    .navigationBarHidden(true)
    .onReceive(
      coalEnvironment.$toastType,
      perform: handleToast
    )
  }
  
  @ViewBuilder
  private var navbarView: some View {
    if isShowNavBar, let pageType = pageType {
      CoalNavBar(
        pageType: pageType,
        leadingAction: leftAction,
        trailingAction: rightAction
      )
    }
  }
  
  @ViewBuilder
  private var contentView: some View {
    if isScrollView {
      ScrollView(showsIndicators: false) {
        content
      }
    } else {
      content
    }
  }

  @ViewBuilder
  private var backgroundView: some View {
    if let image = backgroundImage {
      image
        .resizable()
        .edgesIgnoringSafeArea(.all)
    } else if let color = backgroundColor {
      color.edgesIgnoringSafeArea(.all)
    } else {
      Image.mainBackground
        .resizable()
        .edgesIgnoringSafeArea(.all)
    }
  }
  
  @ViewBuilder
  private var loadingOverlay: some View {
    if isLoading || isShowingBottomSheet {
      Color.black.opacity(0.6)
        .edgesIgnoringSafeArea(.all)
    }
    if isLoading {
      ProgressView()
        .scaleEffect(1.5)
    }
  }
  
  @ViewBuilder
  private var bottomSheetView: some View {
    if isShowingBottomSheet {
      VStack {
        Spacer()
        BottomSheetView(
          isShowing: $isShowingBottomSheet,
          isDraggable: true
        ) {
          AnyView(bottomSheetContent)
        }
      }
    }
  }
  
  @ViewBuilder
  private var toastView: some View {
    if isToastVisible {
      ToastView(
        isVisible: $isToastVisible,
        title: toastModel.title,
        subTitle: toastModel.subtitle,
        isError: toastModel.isError,
        onDismiss: {
          isToastVisible = false
          coalEnvironment.toastType = nil
        }
      )
    }
  }
  
  private func handleToast(toastType: ToastType?) {
    if let toastType = toastType {
      toastModel = toastType.getToastModel()
      isToastVisible = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        dismissToast()
      }
    }
  }
  
  private func dismissToast() {
    isToastVisible = false
    coalEnvironment.toastType = nil
  }
}
