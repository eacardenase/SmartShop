//
//  MyProductListScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/19/26.
//

import SwiftUI

struct MyProductListScreen: View {
    @State private var isPresented = false

    var body: some View {
        Text("MyProductListScreen")
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
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
    }
}
