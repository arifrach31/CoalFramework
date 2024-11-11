//
//  CoalEnvironment.swift
//
//
//  Created by ArifRachman on 05/11/24.
//

import SwiftUI

public class CoalEnvironment: ObservableObject {
  @Published public var toastType: ToastType? = nil
  
  public init() {}
}
