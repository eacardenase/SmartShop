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
            modelType: [Product].self
        )

        products = try await httpClient.load(resource)
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
    }
}
