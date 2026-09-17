//
//  HomeScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/11/26.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case home
    case products
    case cart
    case profile

    var id: AppScreen { self }
}

extension AppScreen {

    @ViewBuilder
    var label: some View {
        switch self {
        case .home: Label("Home", systemImage: "house")
        case .products: Label("Products", systemImage: "star")
        case .cart: Label("Cart", systemImage: "cart")
        case .profile: Label("Profile", systemImage: "person.fill")
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:
            NavigationStack {
                ProductListScreen().navigationTitle("Products")
            }
        case .products:
            NavigationStack {
                Text("Products")
                    .navigationTitle("Products")
                    .requiresAuthentication()
            }
        case .cart:
            NavigationStack {
                Text("Cart")
                    .navigationTitle("Cart")
                    .requiresAuthentication()
            }
        case .profile:
            NavigationStack {
                ProfileScreen()
                    .requiresAuthentication()
            }
        }
    }
}

struct HomeScreen: View {
    @State private var currentTab: AppScreen = .home

    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(AppScreen.allCases, id: \.self) { screen in
                screen.destination.tag(screen)
                    .tabItem {
                        screen.label
                    }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
