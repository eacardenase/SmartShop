//
//  JWTTokenValidator.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import Foundation
import JWTDecode

struct JWTTokenValidator {
    private init() {}

    static func validate(token: String?) -> Bool {
        guard let token else { return false }

        do {
            let jwt = try decode(jwt: token)

            return !jwt.expired
        } catch {
            print("DEBUG: Failed to decode jwt token with error \(error)")

            return false
        }
    }
}
