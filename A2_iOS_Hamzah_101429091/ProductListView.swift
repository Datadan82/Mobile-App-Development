//
//  ProductListView.swift
//  A2_iOS_Hamzah_101429091
//
//  Created by Hamza hafez on 2025-03-28.
//
import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        List(viewModel.products, id: \.id) { product in
            VStack(alignment: .leading) {
                Text(product.name ?? "")
                    .font(.headline)
                Text(product.desc ?? "")
                    .font(.subheadline)
            }
        }
        .navigationTitle("All Products")
    }
}

