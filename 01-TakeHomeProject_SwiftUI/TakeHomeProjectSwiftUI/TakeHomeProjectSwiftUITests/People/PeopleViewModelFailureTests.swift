 //
//  PeopleViewModelFailureTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

import XCTest
@testable import TakeHomeProjectSwiftUI

final class PeopleViewModelFailureTests: XCTestCase {

  private var networkingMock: NetworkingManagerImplementation!
  private var viewModel: PeopleViewModel!
  
  override func setUp() {
    networkingMock = NetworkManagerUserResponseFailureMock()
    viewModel = PeopleViewModel(networkingManager: networkingMock)
  }
  
  override func tearDown() {
    networkingMock = nil
    viewModel = nil
  }

  
  func test_with_unsuccessful_response_error_is_handled() async {
    
    XCTAssertFalse(viewModel.isLoading, "View model should not load any data")
    
    defer {
      XCTAssertFalse(viewModel.isLoading,
                     "View model should not load any data")
      XCTAssertEqual(viewModel.viewState, .finished,
                     "View model view state should be finished")
    }
    
    await viewModel.fetchUsers()
    
    XCTAssertTrue(viewModel.hasError, "View model should have an error")
    XCTAssertNotNil(viewModel.error, "View model error should be set")
  }
  
}
