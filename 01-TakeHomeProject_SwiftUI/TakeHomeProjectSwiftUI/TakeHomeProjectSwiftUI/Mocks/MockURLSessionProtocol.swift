//
//  MockURLSessionProtocol.swift
//  TakeHomeProjectSwiftUITests
//
//  Created by Kevin on 18.03.23.
//

#if DEBUG
import Foundation

/// A class that will allow us to control how the URLSession works
class MockURLSessionProtocol: URLProtocol {
  
  /// a closure that will simulate our request and get back response and data
  static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
  
  
  /// Allows us to control if it can handle a given request
  /// - Parameter request: request that we want to initialize
  /// - Returns: a bool, in case of true it will give us a value for the Mock request
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  
  /// Returns a fake version of the request
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  
  /// The function that allows us to control the mock response that we get back from the MockURLSession
  override func startLoading() {
    
    guard let handler = MockURLSessionProtocol.loadingHandler else {
      fatalError("Loading handler is not set")
    }
    
    let (response, data) = handler()
    
    // send back the response in our URLSession
    client?.urlProtocol(self,
                        didReceive: response,
                        cacheStoragePolicy: .notAllowed)
    
    if let data = data {
      // send data back to our URLSession
      client?.urlProtocol(self, didLoad: data)
    }
    
    // notify the URLSession that we finished loading
    client?.urlProtocolDidFinishLoading(self)
  }
  
  
  /// will stop loading data to the URLSession
  override func stopLoading() {
    
  }
  
}

#endif
