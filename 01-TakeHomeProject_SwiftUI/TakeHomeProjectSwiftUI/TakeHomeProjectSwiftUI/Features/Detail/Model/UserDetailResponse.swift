//
//  UserDetailResponse.swift
//  TakeHomeProjectSwiftUI
//
//  Created by Kevin on 11.03.23.
//

import Foundation


// MARK: - UserDetailResponse -

struct UserDetailResponse: Codable, Equatable {
  let data: User
  let support: Support
}
