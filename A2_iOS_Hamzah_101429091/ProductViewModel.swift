//
//  ProductViewModel.swift
//  A2_iOS_Hamzah_101429091
//
//  Created by Hamza hafez on 2025-03-28.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var currentIndex = 0

    let context = PersistenceController.shared.container.viewContext

    init() {
        fetchProducts()
        if products.isEmpty {
            preloadData()
        }
    }

    func fetchProducts() {
        let request = NSFetchRequest<Product>(entityName: "Product")
        do {
            products = try context.fetch(request)
        } catch {
            print("Error fetching products: \(error)")
        }
    }

    func preloadData() {
        for i in 1...10 {
            let newProduct = Product(context: context)
            newProduct.id = UUID()
            newProduct.name = "Product \(i)"
            newProduct.desc = "Description \(i)"
            newProduct.price = Double(i * 10)
            newProduct.provider = "Provider \(i)"
        }
        saveContext()
        fetchProducts()
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    func addProduct(name: String, desc: String, price: Double, provider: String) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.desc = desc
        newProduct.price = price
        newProduct.provider = provider
        saveContext()
        fetchProducts()
    }

    func search(term: String) {
        let request = NSFetchRequest<Product>(entityName: "Product")
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@ OR desc CONTAINS[cd] %@", term, term)
        do {
            products = try context.fetch(request)
        } catch {
            print("Search error: \(error)")
        }
    }

    func next() {
        if currentIndex < products.count - 1 {
            currentIndex += 1
        }
    }

    func previous() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    var currentProduct: Product? {
        if products.indices.contains(currentIndex) {
            return products[currentIndex]
        }
        return nil
    }
}
