//
//  RegistrationScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/10/26.
//

import SwiftUI

struct RegistrationScreen: View {
    @Environment(\.authenticationController) private
        var authenticationController
    @Environment(\.dismiss) var dismiss

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String?

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

            Button("Sign Up") {
                Task {
                    await register()
                }
            }
            .buttonSizing(.flexible)
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)

            Text(message ?? "")
        }
        .navigationTitle("Register")
    }

    private func register() async {
        do {
            let response = try await authenticationController.register(
                username: username,
                password: password
            )

            print("DEBUG: \(response)")

            if response.success {
                dismiss()
            } else {
                message = response.message ?? ""
            }
        } catch {
            message = error.localizedDescription
        }

        username = ""
        password = ""
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }
    .environment(\.authenticationController, .development)
}
