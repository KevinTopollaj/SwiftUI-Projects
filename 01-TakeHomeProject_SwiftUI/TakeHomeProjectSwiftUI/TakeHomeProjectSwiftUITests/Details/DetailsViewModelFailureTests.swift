//
//  DetailsViewModelFailureTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

import XCTest

@testable import TakeHomeProjectSwiftUI

final class DetailsViewModelFailureTests: XCTestCase {

  private var networkingMock: NetworkingManagerImplementation!
  private var viewModel: DetailViewModel!
  
  override func setUp() {
    networkingMock = NetworkingManagerUserDetailsResponseFailureMock()
    viewModel = DetailViewModel(networkingManager: networkingMock)
  }
  
  override func tearDown() {
    networkingMock = nil
    viewModel = nil
  }
  
  func test_with_unsuccessful_response_error_is_handled() async {
    
    XCTAssertFalse(viewModel.isLoading,
                   "View model should not load any data")
    
    defer {
      XCTAssertFalse(viewModel.isLoading,
                     "View model should not load any data")
    }
    
    await viewModel.fetchDetails(for: 1)
    
    XCTAssertTrue(viewModel.hasError, "The view model error should be true")
    
    XCTAssertNotNil(viewModel.error, "The view model error should not be nil")
    
  }

}
