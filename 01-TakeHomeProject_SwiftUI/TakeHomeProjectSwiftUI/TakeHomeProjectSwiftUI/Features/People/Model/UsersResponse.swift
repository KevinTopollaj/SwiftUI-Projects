//
//  UsersResponse.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 11.03.23.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable, Equatable {
  let page, perPage, total, totalPages: Int
  let data: [User]
  let support: Support
}
