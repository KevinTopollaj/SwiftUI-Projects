//
//  DetailViewModel.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import Foundation

final class DetailViewModel: ObservableObject {
  
  @Published private(set) var userInfo: UserDetailResponse?
  @Published private(set) var error: NetworkingManager.NetworkingError?
  @Published private(set) var isLoading = false
  @Published var hasError = false
  
  private let networkingManager: NetworkingManagerImplementation!
  
  init(networkingManager: NetworkingManagerImplementation = NetworkingManager.shared) {
    self.networkingManager = networkingManager
  }
  
  @MainActor
  func fetchDetails(for id: Int) async {
    
    isLoading = true
    
    defer { isLoading = false }
    
    do {
      
      self.userInfo = try await networkingManager.request(session: .shared,
                                                          .detail(id: id),
                                                          type: UserDetailResponse.self)
      
    } catch {
      
      self.hasError = true
      if let networingError = error as? NetworkingManager.NetworkingError {
        self.error = networingError
      } else {
        self.error = .custom(error: error)
      }
    }
    
  }
  
}
