//
//  CartView.swift
//  Split
//
//  Created by Rohan Agrawal on 4/18/23.
//

import Foundation
import SwiftUI

struct CartView: View {
    let cartItems = [
        CartItem(name: "Product 1", price: 20.0, quantity: 2),
        CartItem(name: "Product 2", price: 30.0, quantity: 1),
        CartItem(name: "Product 3", price: 15.0, quantity: 3)
    ]
    
    var subtotal: Double {
        cartItems.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
    
    var body: some View {
        VStack {
            List(cartItems) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text("$\(item.price, specifier: "%.2f")")
                    Text("x \(item.quantity)")
                }
            }
            
            HStack {
                Text("Subtotal:")
                Spacer()
                Text("$\(subtotal, specifier: "%.2f")")
            }
            .padding()
        }
        .navigationTitle("Cart")
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    var quantity: Int
}
