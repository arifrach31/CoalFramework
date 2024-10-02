//
//  AccountView.swift
//  CoalFramework
//
//  Created by ArifRachman on 27/09/24.
//

import SwiftUI
import CoalCore
import CoalView

public struct AccountView: View {
  public var navigator: CoalNavigatorProtocol?
  
  public init(navigator: CoalNavigatorProtocol? = nil) {
    self.navigator = navigator
  }
  
  public var body: some View {
    VStack(alignment: .center) {
      Text("Account Page")
    }
  }
}

struct AccountView_Previews: PreviewProvider {
  static var previews: some View {
    AccountView()
  }
}

extension AccountView: CoalTabInfoProviding {
  public func coalTabInfo() -> CoalTabInfo {
    return CoalTabInfo(title: CoalString.account, icon: UIImage.icAccount)
  }
}
