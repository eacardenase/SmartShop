//
//  LoginScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(\.authenticationController) private
        var authenticationController

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String?
    @AppStorage("userId") private var userId: Int?

    private var isFormValid: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && password.trimmingCharacters(in: .whitespacesAndNewlines).count
                >= 6
    }

    var body: some View {
        Form {
            TextField("Username", text: $username)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            SecureField("Password", text: $password)
                .textInputAutocapitalization(.never)

            Button("Log in") {
                Task {
                    await login()
                }
            }
            .buttonSizing(.flexible)
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)

            Text(message ?? "")
        }
        .navigationTitle("Login")
    }

    private func login() async {
        do {
            let response = try await authenticationController.login(
                username: username,
                password: password
            )

            guard response.success else {
                message = response.message ?? ""

                return
            }

            print("DEBUG: \(response.token)")

            KeychainStore.set(
                response.token,
                forKey: "\(response.userId)_jwt_token"
            )

            userId = response.userId
        } catch {
            print("DEBUG: \(error)")
            message = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }
    .environment(\.authenticationController, .development)
}
