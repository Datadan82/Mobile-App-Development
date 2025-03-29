//
//  ContentView.swift
//  A2_iOS_Hamzah_101429091
//
//  Created by Hamza hafez on 2025-03-28.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                if let product = viewModel.currentProduct {
                    Text("Name: \(product.name ?? "")")
                        .font(.title2)
                    Text("Description: \(product.desc ?? "")")
                    Text("Price: $\(product.price, specifier: "%.2f")")
                    Text("Provider: \(product.provider ?? "")")
                } else {
                    Text("No product available")
                }

                HStack {
                    Button("Previous") {
                        viewModel.previous()
                    }
                    .disabled(viewModel.currentIndex == 0)

                    Button("Next") {
                        viewModel.next()
                    }
                    .disabled(viewModel.currentIndex >= viewModel.products.count - 1)
                }

                TextField("Search by name or description", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: searchText) { term in
                        if term.isEmpty {
                            viewModel.fetchProducts()
                        } else {
                            viewModel.search(term: term)
                        }
                    }

                NavigationLink("Add Product", destination: AddProductView(viewModel: viewModel))
                NavigationLink("View All Products", destination: ProductListView(viewModel: viewModel))
            }
            .padding()
            .navigationTitle("Product Viewer")
        }
    }
}
