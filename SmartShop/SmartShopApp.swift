//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/7/26.
//

import SwiftUI

@main
struct SmartShopApp: App {
    @State private var token: String?
    @State private var isLoading = true

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Group {
                    if isLoading {
                        ProgressView("Loading...")
                    } else {
                        if JWTTokenValidator.validate(token: token) {
                            Text("Home Screen")
                        } else {
                            LoginScreen()
                        }
                    }
                }
            }
            .environment(\.authenticationController, .development)
            .onAppear {
                token = KeychainStore.get("jwt_token")
                isLoading = false
            }
        }
    }
}
