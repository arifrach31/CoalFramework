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
  private var toastModel: ToastModel
  
  @Binding private var isShowingBottomSheet: Bool
  @Binding private var isToastVisible: Bool
  @EnvironmentObject private var coalEnvironment: CoalEnvironment
  
  public init(
    pageType: PageType? = nil,
    leftAction: (() -> Void)? = nil,
    rightAction: (() -> Void)? = nil,
    backgroundImage: Image? = nil,
    backgroundColor: Color? = .white,
    isShowNavBar: Bool = true,
    isLoading: Bool = false,
    isShowingBottomSheet: Binding<Bool> = .constant(false),
    isToastVisible: Binding<Bool> = .constant(false),
    toastType: ToastType = .genericError,
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
    self._isToastVisible = isToastVisible
    self.toastModel = toastType.getToastModel()
    self.content = content()
  }
  
  public var body: some View {
    ZStack {
      backgroundView
      VStack {
        navbarView
        content
      }
      .blur(radius: (isLoading || isShowingBottomSheet) ? 3 : 0)
      loadingOverlay
      bottomSheetView
      toastView
    }
    .navigationBarHidden(true)
    .onReceive(coalEnvironment.$isRegisteredsuccessful) { isRegisteredsuccessful in
      if isRegisteredsuccessful != nil {
        isToastVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          isToastVisible = false
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
      if isShowingBottomSheet, let content = bottomSheetContent {
        VStack {
          Spacer()
          BottomSheetView(isShowing: $isShowingBottomSheet, dragable: true) {
            content
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
          isError: toastModel.isError
        )
      }
    }
  }
}
