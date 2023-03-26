//
//  PeopleViewModelSuccessTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

import XCTest
@testable import TakeHomeProjectSwiftUI

final class PeopleViewModelSuccessTests: XCTestCase {
  
  private var networkingMock: NetworkingManagerImplementation!
  private var viewModel: PeopleViewModel!
  
  override func setUp() {
    networkingMock = NetworkManagerUserResponseSuccessMock()
    viewModel = PeopleViewModel(networkingManager: networkingMock)
  }
  
  override func tearDown() {
    networkingMock = nil
    viewModel = nil
  }

  func test_with_successful_response_users_array_is_set() async throws {
    
    XCTAssertFalse(viewModel.isLoading, "View model should not load any data")
    
    defer {
      XCTAssertFalse(viewModel.isLoading, "View model should not load any data")
      XCTAssertEqual(viewModel.viewState, .finished, "View model view state should be finished")
    }
    
    await viewModel.fetchUsers()
    
    XCTAssertEqual(viewModel.users.count, 6,
                   "There shouuld be 6 users in our users array")
    
    
  }
  
  func test_with_successful_paginated_response_users_array_is_set() async throws {
    
    XCTAssertFalse(viewModel.isLoading, "View model should not load any data")
    
    defer {
      XCTAssertFalse(viewModel.isFetching, "View model should not be fetching any data")
      XCTAssertEqual(viewModel.viewState, .finished, "View model view state should be finished")
    }

    await viewModel.fetchUsers()
    
    XCTAssertEqual(viewModel.users.count, 6,
                   "There shouuld be 6 users in our users array")
    
    await viewModel.fetchNextPageOfUsers()
    
    XCTAssertEqual(viewModel.users.count, 12,
                   "There shouuld be 12 users in our users array")
    
    XCTAssertEqual(viewModel.page, 2, "There should be 2 pages")
  }

  
  func test_with_reset_called_values_are_reset() async throws {
    
    defer {
      
      XCTAssertEqual(viewModel.users.count, 6,
                     "There shouuld be 6 users in our users array")
      
      XCTAssertEqual(viewModel.page, 1,
                     "There should be 1 page")
      
      XCTAssertEqual(viewModel.totalPages, 2,
                     "There should be 2 total pages")
      
      XCTAssertEqual(viewModel.viewState, .finished,
                     "View model view state should be finished")
      
      XCTAssertFalse(viewModel.isLoading,
                     "View model should not load any data")
      
    }
    
    await viewModel.fetchUsers()
    
    XCTAssertEqual(viewModel.users.count, 6,
                   "There shouuld be 6 users in our users array")
    
    await viewModel.fetchNextPageOfUsers()
    
    XCTAssertEqual(viewModel.users.count, 12,
                   "There shouuld be 12 users in our users array")
    
    XCTAssertEqual(viewModel.page, 2, "There should be 2 pages")
    
    await viewModel.fetchUsers()
    
  }
  
  
  func test_with_last_user_func_returns_true() async {
    
    await viewModel.fetchUsers()
    
    let userData = try! StaticJSONMapper.decode(file: "UsersStaticData",
                                                type: UsersResponse.self)
    
    let hasReachedEnd = viewModel.hasReachedTheEnd(of: userData.data.last!)
    
    XCTAssertTrue(hasReachedEnd, "The last user should match")
    
  }
}
