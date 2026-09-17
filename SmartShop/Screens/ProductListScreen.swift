//
//  ProductListScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/17/26.
//

import SwiftUI

struct ProductListScreen: View {
    @Environment(ProductStore.self) private var productStore

    var body: some View {
        List(productStore.products) { product in
            ProductCellView(product: product)
        }
        .navigationTitle("Products")
        .task {
            do {
                try await productStore.loadAllProducts()
            } catch {
                print(
                    "DEBUG: Failed to load all products with error: \(error.localizedDescription)"
                )
            }

        }
    }
}

#Preview {
    NavigationStack {
        ProductListScreen()
            .environment(ProductStore(httpClient: .development))
    }
}
