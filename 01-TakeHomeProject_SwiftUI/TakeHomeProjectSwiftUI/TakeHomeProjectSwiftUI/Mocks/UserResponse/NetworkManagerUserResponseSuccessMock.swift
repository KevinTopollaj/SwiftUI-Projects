//
//  NetworkManagerUserResponseSuccessMock.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 19.03.23.
//

#if DEBUG

import Foundation

class NetworkManagerUserResponseSuccessMock: NetworkingManagerImplementation {
  
  func request<T>(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
    
    return try StaticJSONMapper.decode(file: "UsersStaticData",
                                       type: UsersResponse.self) as! T
  }
  
  func request(session: URLSession, _ endpoint: TakeHomeProjectSwiftUI.Endpoint) async throws { }
  
}

#endif
