//
//  CreateValidatorFailureMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 20.03.23.
//

#if DEBUG

import Foundation

class CreateValidatorFailureMock: CreateValidatorImplementation {
  
  func validate(_ person: TakeHomeProjectSwiftUI.NewPerson) throws {
    throw CreateValidator.CreateValidatorError.invalidFirstName
  }
  
}

#endif
