//
//  NetworkingManagerUserDetailsResponseSuccessMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

#if DEBUG

import Foundation

class NetworkingManagerUserDetailsResponseSuccessMock: NetworkingManagerImplementation {
  
  func request<T: Codable>(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint, type: T.Type) async throws -> T {
    
    return try StaticJSONMapper.decode(file: "SingleUserStaticData",
                                       type: UserDetailResponse.self) as! T
    
  }
  
  func request(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint) async throws { }
  
}

#endif
