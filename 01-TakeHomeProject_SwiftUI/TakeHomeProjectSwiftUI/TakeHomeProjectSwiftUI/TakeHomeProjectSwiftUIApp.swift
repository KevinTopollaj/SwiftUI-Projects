//
//  TakeHomeProjectSwiftUIApp.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 11.03.23.
//

import SwiftUI

@main
struct TakeHomeProjectSwiftUIApp: App {
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      
      TabView {
        PeopleView()
          .tabItem {
            Symbols.person
            Text("Home")
          }
        SettingsView()
          .tabItem {
            Symbols.gear
            Text("Settings")
          }
      }
      
    }
  }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    #if DEBUG
    
    print("✅ Is UI Test Running: \(UITestingHelper.isUITesting)")
    
    #endif
    
    return true
  }
  
}
