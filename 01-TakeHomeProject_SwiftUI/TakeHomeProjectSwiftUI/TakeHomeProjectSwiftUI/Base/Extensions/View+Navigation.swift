//
//  View+Navigation.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 24.03.23.
//

import SwiftUI

extension View {
  
  @ViewBuilder
  func embedInNavigation() -> some View {
    
    if #available(iOS 16.0, *) {
      NavigationStack {
        self
      }
    } else {
      NavigationView {
        self
      }
    }
    
  }
  
}
