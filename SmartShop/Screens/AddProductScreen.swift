//
//  AddProductScreen.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/19/26.
//

import SwiftUI

struct AddProductScreen: View {
    @Environment(ProductStore.self) var productStore
    @Environment(\.dismiss) var dismiss
    @AppStorage("userId") private var userId: Int?

    @State private var name = ""
    @State private var description = ""
    @State private var price: Double = 0

    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && !description.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            && price > 0
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter Name", text: $name)

                TextField(
                    "Price",
                    value: $price,
                    format: .number
                )
                .keyboardType(.numberPad)

                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }

            }
            .navigationTitle("New Product")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        Task {
                            await saveProduct()
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    private func saveProduct() async {
        guard let userId else { return }

        let product = Product(
            name: name,
            description: description,
            price: price,
            photoUrl: URL(string: "http://localhost:8080/uploads/chair-photo.png"),
            userId: userId
        )

        do {
            try await productStore.saveProduct(product)
            dismiss()
        } catch {
            print(
                "DEBUG: Failed to save product with error \(error.localizedDescription)"
            )
        }
    }
}

#Preview {
    NavigationStack {
        AddProductScreen()
            .environment(ProductStore(httpClient: .development))
    }
}
