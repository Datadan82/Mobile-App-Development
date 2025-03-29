//
//  AddProductView.swift
//  A2_iOS_Hamzah_101429091
//
//  Created by Hamza hafez on 2025-03-28.
//
import SwiftUI

struct AddProductView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var desc = ""
    @State private var price = ""
    @State private var provider = ""

    var body: some View {
        VStack(spacing: 15) {
            TextField("Product Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Description", text: $desc)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Price", text: $price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            #if os(iOS)
                .keyboardType(.decimalPad)
            #endif

            TextField("Provider", text: $provider)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button("Add Product") {
                if let priceVal = Double(price) {
                    viewModel.addProduct(name: name, desc: desc, price: priceVal, provider: provider)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("Add Product")
    }
}

