//
//  NetworkManagerUserResponseFailureMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

#if DEBUG

import Foundation

class NetworkManagerUserResponseFailureMock: NetworkingManagerImplementation {
  
  func request<T>(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
    
    throw NetworkingManager.NetworkingError.invalidUrl
    
  }
  
  func request(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint) async throws { }
  
}

#endif
