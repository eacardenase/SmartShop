//
//  MyProductListScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/19/26.
//

import SwiftUI

struct MyProductListScreen: View {
    @State private var isPresented = false
    @Environment(ProductStore.self) private var productStore
    @AppStorage("userId") var userId: Int?

    var body: some View {
        List(productStore.myProducts) { product in
            ProductCellView(product: product)
        }
        .navigationTitle("My Products")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add", systemImage: "plus", role: .confirm) {
                    isPresented.toggle()
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddProductScreen()
        }
        .task {
            await loadMyProducts()
        }
    }

    private func loadMyProducts() async {
        do {
            try await productStore.loadProducts(for: userId)
        } catch {
            print(
                "DEBUG: Failed to load all products with error: \(error.localizedDescription)"
            )
        }
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
            .environment(ProductStore(httpClient: .development))
    }
}
