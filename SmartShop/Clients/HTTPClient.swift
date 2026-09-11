//
//  HTTPClient.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import Foundation

struct ErrorResponse: Codable {
    let message: String?
}

enum NetworkError: Error {
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            NSLocalizedString(
                "Bad Request (400): Unable to perform the request.",
                comment: "badRequestError"
            )
        case .decodingError(let error):
            NSLocalizedString(
                "Unable to decode successfully with error: \(error)",
                comment: "decodingError"
            )
        case .invalidResponse:
            NSLocalizedString(
                "Invalid response.",
                comment: "invalidResponseError"
            )
        case .errorResponse(let errorResponse):
            NSLocalizedString(
                "Error \(errorResponse.message ?? "")",
                comment: "Error Response"
            )
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)

    var name: String {
        switch self {
        case .get: "GET"
        case .post: "POST"
        case .delete: "DELETE"
        case .put: "PUT"
        }
    }
}

struct Resourse<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]?
    var modelType: T.Type
}

struct HTTPClient {
    private var session: URLSession

    init() {
        let configuration = URLSessionConfiguration.default

        configuration.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]

        session = URLSession(configuration: configuration)
    }

    func load<T: Codable>(_ resource: Resourse<T>) async throws -> T {
        var request = URLRequest(url: resource.url)

        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(
                url: resource.url,
                resolvingAgainstBaseURL: false
            )

            components?.queryItems = queryItems

            guard let url = components?.url else {
                throw NetworkError.badRequest
            }

            request.url = url
        case .post(let data), .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .delete:
            request.httpMethod = resource.method.name
        }

        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            break
        default:
            let errorResponse = try JSONDecoder().decode(
                ErrorResponse.self,
                from: data
            )

            throw NetworkError.errorResponse(errorResponse)
        }

        do {
            return try JSONDecoder().decode(resource.modelType, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

extension HTTPClient {
    static var development: HTTPClient {
        HTTPClient()
    }
}
