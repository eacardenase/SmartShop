//
//  ProductStore.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/17/26.
//

import Foundation
import Observation

@Observable
class ProductStore {
    let httpClient: HTTPClient
    private(set) var products = [Product]()
    private(set) var myProducts = [Product]()

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func loadAllProducts() async throws {
        let resource = Resourse(
            url: Constants.Urls.products,
            modelType: ProductsResponse.self
        )

        let response = try await httpClient.load(resource)

        guard response.success, let allProducts = response.products else {
            throw ProductsError.message(response.message)
        }

        self.products = allProducts
    }

    func loadProducts(for userId: Int?) async throws {
        guard let userId else { return }

        let resource = Resourse(
            url: Constants.Urls.loadProducts(for: userId),
            modelType: ProductsResponse.self
        )

        let response = try await httpClient.load(resource)

        guard response.success, let products = response.products else {
            throw ProductsError.message(response.message)
        }

        myProducts = products
    }

    func saveProduct(_ product: Product) async throws {
        let resource = Resourse(
            url: Constants.Urls.products,
            method: .post(product.encode()),
            modelType: CreateProductResponse.self
        )

        let response = try await httpClient.load(resource)

        guard response.success else {
            throw ProductSaveError.operationFailed(response.message ?? "")
        }

        myProducts.append(product)
    }
}
