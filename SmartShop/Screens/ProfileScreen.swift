//
//  ProfileScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import SwiftUI

struct ProfileScreen: View {
    @AppStorage("userId") private var userId: Int?

    var body: some View {
        Button("Sign out") {
            KeychainStore<String>.delete("jwt_token")
            userId = nil
        }
        .navigationTitle("Profile")
    }
}
