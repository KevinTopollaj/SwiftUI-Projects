//
//  DetailsViewModelSuccessTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

import XCTest

@testable import TakeHomeProjectSwiftUI

final class DetailsViewModelSuccessTests: XCTestCase {

  private var networkingMock: NetworkingManagerImplementation!
  private var viewModel: DetailViewModel!
  
  override func setUp() {
    networkingMock = NetworkingManagerUserDetailsResponseSuccessMock()
    viewModel = DetailViewModel(networkingManager: networkingMock)
  }
  
  override func tearDown() {
    networkingMock = nil
    viewModel = nil
  }
  
  func test_with_successful_response_users_details_is_set() async throws {
    
    XCTAssertFalse(viewModel.isLoading,
                   "View model should not load any data")
    
    defer {
      XCTAssertFalse(viewModel.isLoading,
                     "View model should not load any data")
    }
    
    await viewModel.fetchDetails(for: 1)
    
    XCTAssertNotNil(viewModel.userInfo,
                    "The user info in the view model should not be nil")
    
    let userDetailData = try StaticJSONMapper.decode(file: "SingleUserStaticData",
                                                     type: UserDetailResponse.self)
    
    XCTAssertEqual(viewModel.userInfo, userDetailData,
                   "The response from our networking mock should match")
  }
}
