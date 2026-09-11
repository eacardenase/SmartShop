//
//  DTOs.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String
}

struct RegisterResponse: Codable {
    let success: Bool
    let message: String?
}

struct LoginResponse: Codable {
    let success: Bool
    let message: String?
    let userId: Int
    let username: String
    let token: String
}
