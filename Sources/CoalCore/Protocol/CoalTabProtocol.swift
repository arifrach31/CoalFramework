//
//  CoalTabProtocol.swift
//
//
//  Created by ArifRachman on 02/10/24.
//

import SwiftUI

public protocol CoalTabProtocol {
  func addTabs(_ views: [any View])
  func addTab<Content: View>(_ view: Content, at index: Int)
  func removeTab(at index: Int)
  func updateTab(at index: Int, title: String?, icon: UIImage?)
  func navigateToTab(at index: Int)
}
