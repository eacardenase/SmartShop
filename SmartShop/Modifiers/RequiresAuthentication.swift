//
//  RequiresAuthentication.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import SwiftUI

struct RequiresAuthentication: ViewModifier {
    @State private var isLoading = true
    @AppStorage("userId") var userId: String?

    func body(content: Content) -> some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
            } else {
                if userId != nil {
                    content
                } else {
                    LoginScreen()
                }
            }
        }
        .onAppear(perform: checkAuthentication)
    }

    private func checkAuthentication() {
        // isLoading = false

        guard
            let token = KeychainStore<String>.get("jwt_token"),
            JWTTokenValidator.validate(token: token)
        else {
            userId = nil
            isLoading = false

            return
        }

        isLoading = false
    }
}

extension View {
    func requiresAuthentication() -> some View {
        modifier(RequiresAuthentication())
    }
}
