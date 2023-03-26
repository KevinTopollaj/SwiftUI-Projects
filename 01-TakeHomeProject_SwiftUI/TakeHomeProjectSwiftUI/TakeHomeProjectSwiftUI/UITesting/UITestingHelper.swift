//
//  UITestingHelper.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 20.03.23.
//

#if DEBUG

import Foundation

/// Will let us to access launch Arguments and Environment within our main app
struct UITestingHelper {
  
  static var isUITesting: Bool {
    ProcessInfo.processInfo.arguments.contains("-ui-testing")
  }
  
  static var isPeopleNetworkingSuccessful: Bool {
    ProcessInfo.processInfo.environment["-people-networking-success"] == "1"
  }
  
  static var isDetailsNetworkingSuccessful: Bool {
    ProcessInfo.processInfo.environment["-details-networking-success"] == "1"
  }
  
  static var isCreateNetworkingSuccessful: Bool {
    ProcessInfo.processInfo.environment["-create-networking-success"] == "1"
  }
}

#endif
