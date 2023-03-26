//
//  Endpoint.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 12.03.23.
//

import Foundation

enum Endpoint {
  
  case people(page: Int)
  case detail(id: Int)
  case create(submitionData: Data?)
  
}

// MARK: - MethodType -

extension Endpoint {
  enum MethodType: Equatable {
    case GET
    case POST(data: Data?)
  }
}
 

extension Endpoint {
  
  var host: String { "reqres.in" }
  
  var path: String {
    switch self {
    case .people, .create:
      return "/api/users"
    case .detail(let id):
      return "/api/users/\(id)"
    }
  }
  
  var methodType: MethodType {
    switch self {
    case .people, .detail:
      return .GET
    case .create(let data):
      return .POST(data: data)
    }
  }
  
  var queryItems: [String: String]? {
    switch self {
    case .people(page: let page):
      return ["page":"\(page)"]
    default:
      return nil
    }
  }
}


extension Endpoint {
  
  var url: URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    urlComponents.path = path
    
    var requestQueryItems = [URLQueryItem]()
    
    queryItems?.forEach { item in
      requestQueryItems.append(URLQueryItem(name: item.key,
                                            value: item.value))
    }
    
    #if DEBUG
      requestQueryItems.append( URLQueryItem(name: "delay", value: "2"))
    #endif
    
    urlComponents.queryItems = requestQueryItems 
    
    return urlComponents.url
  }
}
