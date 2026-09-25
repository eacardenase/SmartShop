//
//  Constants.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import Foundation

struct Constants {
    struct Urls {
        static let register = URL(string: "http://localhost:8080/api/auth/register")!
        static let login = URL(string: "http://localhost:8080/api/auth/login")!
        static let products = URL(string: "http://localhost:8080/api/products")!
        static let myProducts = URL(string: "http://localhost:8080/api/products")!

        static func loadProducts(for userId: Int) -> URL {
            URL(string: "http://localhost:8080/api/products/user/\(userId)")!
        }
    }
}
