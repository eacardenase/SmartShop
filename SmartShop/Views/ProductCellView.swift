//
//  ProductCellView.swift
//  SmartShop
//
//  Created by Edwin Cardenas on 9/17/26.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: product.photoUrl) { img in
                img
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(.rect(cornerRadius: 25, style: .continuous))
                    .scaledToFit()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 25))
                        .frame(width: 300, height: 300)

                    ProgressView()
                }
            }

            Text(product.name)
                .font(.title)

            Text(product.price, format: .currency(code: "USD"))
                .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ProductCellView(product: Product.preview)
}
