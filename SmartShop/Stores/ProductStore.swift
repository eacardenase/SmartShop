//
//  ProductStore.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/17/26.
//

import Observation

@Observable
class ProductStore {
    let httpClient: HTTPClient
    private(set) var products = [Product]()

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
}
