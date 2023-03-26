//
//  CreateViewModelValidationFailureTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 20.03.23.
//

import XCTest

@testable import TakeHomeProjectSwiftUI

final class CreateViewModelValidationFailureTests: XCTestCase {

  private var networkingMock: NetworkManagerCreateSuccessMock!
  private var validatorMock: CreateValidatorFailureMock!
  private var viewModel: CreateViewModel!
  
  override func setUp() {
    
    networkingMock = NetworkManagerCreateSuccessMock()
    validatorMock = CreateValidatorFailureMock()
    viewModel = CreateViewModel(networkingManager: networkingMock,
                                validator: validatorMock)
  }
  
  override func tearDown() {
    
    networkingMock = nil
    validatorMock = nil
    viewModel = nil
    
  }

  func test_with_invalid_form_submission_state_is_invalid() async {
    
    XCTAssertNil(viewModel.state,
                 "The view model state should be nil initialy")
    
    defer {
      XCTAssertEqual(viewModel.state,
                           .unsuccessful,
                           "The view model state should be unsuccessful")
    }
    
    await viewModel.create()
    
    XCTAssertTrue(viewModel.hasError, "The view model should have an error")
    XCTAssertNotNil(viewModel.error, "The view model error property should not be nil")
    
    XCTAssertEqual(viewModel.error,
                   .validation(error: CreateValidator.CreateValidatorError.invalidFirstName),
                   "The view model error shuld be invalid first name")
    
  }
}
