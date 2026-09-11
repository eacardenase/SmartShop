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
