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
  private let isScrollView: Bool
  private let bottomSheetContent: any View
  
  @EnvironmentObject private var coalEnvironment: CoalEnvironment
  @State private var isToastVisible: Bool = false
  @State private var toastModel: ToastModel = ToastModel()
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
    .onReceive(coalEnvironment.$toastType) { toastType in
      if let toastType = toastType {
        toastModel = toastType.getToastModel()
        isToastVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          isToastVisible = false
          coalEnvironment.toastType = nil
        }
      }
    }
  }
  
  private var navbarView: some View {
    Group {
      if isShowNavBar, let pageType = pageType {
        CoalNavBar(
          pageType: pageType,
          leadingAction: leftAction,
          trailingAction: rightAction
        )
      }
    }
  }
  
  private var contentView: some View {
    Group {
      if isScrollView {
        ScrollView(showsIndicators: false) {
          content
        }
      } else {
        content
      }
    }
  }

  private var backgroundView: some View {
    Group {
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
  }
  
  private var loadingOverlay: some View {
    Group {
      if isLoading || isShowingBottomSheet {
        Color.black.opacity(0.6)
          .edgesIgnoringSafeArea(.all)
      }
      if isLoading {
        ProgressView()
          .scaleEffect(1.5)
      }
    }
  }
  
  private var bottomSheetView: some View {
    Group {
      if isShowingBottomSheet {
        VStack {
          Spacer()
          BottomSheetView(isShowing: $isShowingBottomSheet, dragable: true) {
            AnyView(bottomSheetContent)
          }
        }
      }
    }
  }
  
  private var toastView: some View {
    Group {
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
  }
}
