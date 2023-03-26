//
//  SettingsView.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import SwiftUI

struct SettingsView: View {
  
  @AppStorage(UserDefaultKeys.hapticsEnabled) private var isHapticsEnabled = true
  
  var body: some View {
    
    Form {
      haptics
    }
    .navigationTitle("Settings")
    .embedInNavigation()
    
  }
}


extension SettingsView {
  var haptics: some View {
    Toggle("Enable Haptics", isOn: $isHapticsEnabled)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
