//
//  CreateViewModelFailureTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 20.03.23.
//

import XCTest

@testable import TakeHomeProjectSwiftUI

final class CreateViewModelFailureTests: XCTestCase {

  private var networkingMock: NetworkingManagerImplementation!
  private var validatorMock: CreateValidatorImplementation!
  private var viewModel: CreateViewModel!
  
  override func setUp() {
    
    networkingMock = NetworkManagerCreateFailureMock()
    validatorMock = CreateValidatorSuccessMock()
    viewModel = CreateViewModel(networkingManager: networkingMock,
                                validator: validatorMock)
  }
  
  override func tearDown() {
    
    networkingMock = nil
    validatorMock = nil
    viewModel = nil
    
  }

  func test_with_unsuccessful_response_submission_state_is_unsuccessful() async throws {
    
    XCTAssertNil(viewModel.state,
                 "The view model state should be nil initialy")
    
    defer { XCTAssertEqual(viewModel.state,
                           .unsuccessful,
                           "The view model state should be unsuccessful")
    }
    
    await viewModel.create()
    
    XCTAssertTrue(viewModel.hasError, "The view model should have an error")
    XCTAssertNotNil(viewModel.error, "The view model error should not be nil")
    
    XCTAssertEqual(viewModel.error,
                   .networking(error: NetworkingManager.NetworkingError.invalidUrl),
                   "The view model error should be an networking error with invalid url")
  }
  
}
