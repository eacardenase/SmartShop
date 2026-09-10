//
//  AuthenticationEnvironmentKey.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import SwiftUI

private struct AuthenticationEnvironmentKey: EnvironmentKey {
    static let defaultValue = AuthenticationController(client: HTTPClient())
}

extension EnvironmentValues {
    var authenticationController: AuthenticationController {
        get { self[AuthenticationEnvironmentKey.self] }
        set { self[AuthenticationEnvironmentKey.self] = newValue }
    }
}
