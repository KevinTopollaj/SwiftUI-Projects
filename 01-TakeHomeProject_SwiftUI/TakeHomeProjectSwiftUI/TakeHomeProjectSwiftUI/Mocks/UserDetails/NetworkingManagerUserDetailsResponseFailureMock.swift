//
//  NetworkingManagerUserDetailsResponseFailureMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

#if DEBUG

import Foundation

class NetworkingManagerUserDetailsResponseFailureMock: NetworkingManagerImplementation {
  
  func request<T: Codable>(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint, type: T.Type) async throws -> T {
    
    throw NetworkingManager.NetworkingError.invalidUrl
    
  }
  
  func request(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint) async throws { }
  
}

#endif
