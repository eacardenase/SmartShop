//
//  AuthenticationController.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import Foundation

struct AuthenticationController {
    let httpClient: HTTPClient

    func register(
        username: String,
        password: String
    ) async throws -> RegisterResponse {
        let body = ["username": username, "password": password]
        let bodyData = try JSONEncoder().encode(body)
        let resource = Resourse(
            url: Constants.Urls.register,
            method: .post(bodyData),
            modelType: RegisterResponse.self
        )

        return try await httpClient.load(resource)
    }

    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse {
        let body = ["username": username, "password": password]
        let bodyData = try JSONEncoder().encode(body)
        let resource = Resourse(
            url: Constants.Urls.login,
            method: .post(bodyData),
            modelType: LoginResponse.self
        )

        return try await httpClient.load(resource)
    }
}

extension AuthenticationController {
    static let development = AuthenticationController(httpClient: .development)
}
