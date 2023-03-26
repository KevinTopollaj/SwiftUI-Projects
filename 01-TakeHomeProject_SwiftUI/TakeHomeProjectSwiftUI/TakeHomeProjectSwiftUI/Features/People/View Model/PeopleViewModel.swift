//
//  PeopleViewModel.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import Foundation

final class PeopleViewModel: ObservableObject {
  
  @Published private(set) var users: [User] = []
  @Published private(set) var error: NetworkingManager.NetworkingError?
  @Published private(set) var viewState: ViewState?
  @Published var hasError = false
  
  private(set) var page = 1
  private(set) var totalPages: Int?
  
  private let networkingManager: NetworkingManagerImplementation!
  
  var isLoading: Bool {
    viewState == .loading
  }
  
  var isFetching: Bool {
    viewState == .fetching
  }
  
  init(networkingManager: NetworkingManagerImplementation = NetworkingManager.shared) {
    self.networkingManager = networkingManager
  }
  
  
  @MainActor
  func fetchUsers() async {
    
    reset()
    
    viewState = .loading
    
    defer { viewState = .finished }
    
    do {
      
      let response = try await networkingManager.request(session: .shared,
                                                         .people(page: page),
                                                         type: UsersResponse.self)
      self.totalPages = response.totalPages
      self.users = response.data
      
    } catch {
      
      self.hasError = true
      if let networingError = error as? NetworkingManager.NetworkingError {
        self.error = networingError
      } else {
        self.error = .custom(error: error)
      }
    }
    
  }
  
  @MainActor
  func fetchNextPageOfUsers() async {
    
    guard page != totalPages else { return }
    
    viewState = .fetching
    
    defer { viewState = .finished }
    
    page += 1
    
    do {
      
      let response = try await networkingManager.request(session: .shared,
                                                         .people(page: page),
                                                         type: UsersResponse.self)
      
      self.totalPages = response.totalPages
      self.users += response.data
      
    } catch {
      
      self.hasError = true
      if let networingError = error as? NetworkingManager.NetworkingError {
        self.error = networingError
      } else {
        self.error = .custom(error: error)
      }
    }
    
  }
  
  func hasReachedTheEnd(of user: User) -> Bool {
    users.last?.id == user.id
  }
  
}


// MARK: - State of the View -

extension PeopleViewModel {
  
  enum ViewState {
    case fetching
    case loading
    case finished
  }
  
}


// MARK: - Reset the State -

private extension PeopleViewModel {
  
  func reset() {
    if viewState == .finished {
      users.removeAll()
      page = 1
      totalPages = nil
      viewState = nil
    }
  }
}
