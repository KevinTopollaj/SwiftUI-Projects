//
//  NetworkManagerCreateFailureMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 20.03.23.
//

#if DEBUG

import Foundation

class NetworkManagerCreateFailureMock: NetworkingManagerImplementation {
  
  func request<T: Codable>(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint, type: T.Type) async throws -> T {
    
    return Data() as! T
  }
  
  func request(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint) async throws {
    
    throw NetworkingManager.NetworkingError.invalidUrl
  }
  
}

#endif
