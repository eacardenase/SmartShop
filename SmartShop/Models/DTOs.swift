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

struct Product: Codable, Identifiable {
    var id: Int?
    let name: String
    let description: String
    let price: Double
    let photoUrl: URL?
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case photoUrl = "photo_url"
        case userId = "user_id"
    }
}

extension Product {
    static var preview: Product = .init(
        id: 1,
        name: "Chair",
        description: "This is an awesome chair",
        price: 850,
        photoUrl: URL(string: "http://localhost:8080/uploads/chair-photo.png"),
        userId: 14
    )
}
