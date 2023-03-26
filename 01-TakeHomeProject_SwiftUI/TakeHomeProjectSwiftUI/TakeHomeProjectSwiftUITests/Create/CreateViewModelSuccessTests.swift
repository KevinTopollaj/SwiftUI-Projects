//
//  CreateViewModelSuccessTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 20.03.23.
//

import XCTest

@testable import TakeHomeProjectSwiftUI

final class CreateViewModelSuccessTests: XCTestCase {

  private var networkingMock: NetworkManagerCreateSuccessMock!
  private var validatorMock: CreateValidatorSuccessMock!
  private var viewModel: CreateViewModel!
  
  override func setUp() {
    
    networkingMock = NetworkManagerCreateSuccessMock()
    validatorMock = CreateValidatorSuccessMock()
    viewModel = CreateViewModel(networkingManager: networkingMock,
                                validator: validatorMock)
  }
  
  override func tearDown() {
    
    networkingMock = nil
    validatorMock = nil
    viewModel = nil
    
  }
  
  func test_with_successful_response_submission_state_is_successful() async throws {
    
    XCTAssertNil(viewModel.state,
                 "The view model state should be nil initialy")
    
    defer { XCTAssertEqual(viewModel.state,
                           .successful,
                           "The view model state should be successful")
    }
    
    await viewModel.create()
  }
}
