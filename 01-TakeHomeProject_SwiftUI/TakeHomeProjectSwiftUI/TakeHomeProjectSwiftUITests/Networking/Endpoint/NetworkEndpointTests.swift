//
//  NetworkEndpointTests.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 18.03.23.
//

import XCTest
@testable import TakeHomeProjectSwiftUI

final class NetworkEndpointTests: XCTestCase {

  func test_with_people_endpoint_request_is_valid() {
    
    let endpoint = Endpoint.people(page: 1)
    
    XCTAssertEqual(endpoint.host, "reqres.in", "The host shoud be reqres.in")
    XCTAssertEqual(endpoint.path, "/api/users", "The path shoud be /api/users")
    XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
    XCTAssertEqual(endpoint.queryItems, ["page": "1"], "The query items should be page:1")
    
    XCTAssertEqual(endpoint.url?.absoluteString,
                   "https://reqres.in/api/users?page=1&delay=2",
                   "The generated URL does not match our endpoint")
  }
  
  func test_with_detail_endpoint_request_is_vaild() {
    
    let userID = 1
    let endpoint = Endpoint.detail(id: userID)
    
    XCTAssertEqual(endpoint.host, "reqres.in", "The host shoud be reqres.in")
    XCTAssertEqual(endpoint.path, "/api/users/\(userID)", "The path shoud be /api/users/\(userID)")
    XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")

    XCTAssertNil(endpoint.queryItems, "The query items should be nil")
    
    XCTAssertEqual(endpoint.url?.absoluteString,
                   "https://reqres.in/api/users/\(userID)?delay=2",
                   "The generated URL does not match our endpoint")
    
  }

  func test_with_create_endpoint_request_is_vaild() {
    
    let endpoint = Endpoint.create(submitionData: nil)
    
    XCTAssertEqual(endpoint.host, "reqres.in", "The host shoud be reqres.in")
    XCTAssertEqual(endpoint.path, "/api/users", "The path shoud be /api/users")
    XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
    
    XCTAssertNil(endpoint.queryItems, "The query items should be nil")

    XCTAssertEqual(endpoint.url?.absoluteString,
                   "https://reqres.in/api/users?delay=2",
                   "The generated URL does not match our endpoint")
  }
}
