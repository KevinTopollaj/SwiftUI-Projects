//
//  CreateValidator.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import Foundation

protocol CreateValidatorImplementation {
  
  func validate(_ person: NewPerson) throws
}

struct CreateValidator: CreateValidatorImplementation {
  
  func validate(_ person: NewPerson) throws {
    
    if person.firstName.isEmpty {
      throw CreateValidatorError.invalidFirstName
    }
    
    if person.lastName.isEmpty {
      throw CreateValidatorError.invalidLastName
    }
    
    if person.job.isEmpty {
      throw CreateValidatorError.invalidJob
    }
    
  }
  
}

// MARK: - CreateValidatorError -

extension CreateValidator {
  
  enum CreateValidatorError: LocalizedError {
    case invalidFirstName
    case invalidLastName
    case invalidJob
  }
}

// MARK: - Error description -

extension CreateValidator.CreateValidatorError {
  
  var errorDescription: String? {
    switch self {
    case .invalidFirstName:
      return "First Name can not be empty!"
    case .invalidLastName:
      return "Last Name can not be empty!"
    case .invalidJob:
      return "Job can not be empty!"
    }
  }
}
