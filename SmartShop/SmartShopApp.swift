//
//  SmartShopApp.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/7/26.
//

import SwiftUI

@main
struct SmartShopApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.authenticationController, .development)

        }
    }
}
