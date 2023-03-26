//
//  HapticsManager.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import UIKit

fileprivate final class HapticsManager {
  
  // MARK: - Properties -
  
  static let shared = HapticsManager()
  private let feedback = UINotificationFeedbackGenerator()
  
  // MARK: - Initializer -
  
  private init() {}
  
  // MARK: Methods -
  
  func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    feedback.notificationOccurred(notification)
  }
}

// MARK: - Global Haptic Function -

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
  
  if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
    HapticsManager.shared.trigger(notification)
  }
  
}
