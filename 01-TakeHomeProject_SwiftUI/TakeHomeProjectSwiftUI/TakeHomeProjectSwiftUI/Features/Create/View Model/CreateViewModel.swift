//
//  CreateViewModel.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import Foundation

final class CreateViewModel: ObservableObject {
  
  @Published var person = NewPerson()
  @Published private(set) var state: SubmissionState?
  @Published private(set) var error: FormError?
  @Published var hasError = false
  
  private let networkingManager: NetworkingManagerImplementation!
  private let validator: CreateValidatorImplementation!
  
  init(networkingManager: NetworkingManagerImplementation = NetworkingManager.shared,
       validator: CreateValidatorImplementation = CreateValidator()) {
    
    self.networkingManager = networkingManager
    self.validator = validator
  }
  
  @MainActor
  func create() async {
    
    do {
      
      try validator.validate(person)
      
      state = .submitting
      
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      
      let data = try encoder.encode(person)
      
      try await networkingManager.request(session: .shared,
                                          .create(submitionData: data))
      
      state = .successful
      
    } catch {
      
      self.hasError = true
      self.state = .unsuccessful
      
      switch error {
      case is NetworkingManager.NetworkingError:
        self.error = .networking(error: error as! NetworkingManager.NetworkingError)
      case is CreateValidator.CreateValidatorError:
        self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
      default:
        self.error = .system(error: error)
      }
      
    }
    
  }
}

// MARK: - SubmissionState -

extension CreateViewModel {
  
  enum SubmissionState {
    case unsuccessful
    case successful
    case submitting
  }
}

// MARK: - FormError -

extension CreateViewModel {
  enum FormError: LocalizedError {
    case networking(error: LocalizedError)
    case validation(error: LocalizedError)
    case system(error: Error)
  }
}

// MARK: - CreateViewModel.FormError Equatable -

extension CreateViewModel.FormError: Equatable {
  
  static func ==(lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
    
    switch (lhs, rhs) {
    case (.networking(let lhsType), .networking(error: let rhsType)):
      return lhsType.errorDescription == rhsType.errorDescription
    case (.validation(let lhsType), .validation(error: let rhsType)):
      return lhsType.errorDescription == rhsType.errorDescription
    case (.system(let lhsType), .system(error: let rhsType)):
      return lhsType.localizedDescription == rhsType.localizedDescription
      
    default:
      return false
    }
  }
}

// MARK: - Form Error Description -

extension CreateViewModel.FormError {
  
  var errorDescription: String? {
    switch self {
    case .networking(error: let error),
        .validation(error: let error):
      
      return error.errorDescription
      
    case .system(error: let error):
      
      return error.localizedDescription
    }
  }
}
