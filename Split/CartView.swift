//
//  CartView.swift
//  testing
//
//  Created by Rohan Agrawal on 4/18/23.
//

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
                        .font(.custom("Irish Grover Regular", size: 18))
                    Spacer()
                    Text("$\(item.price, specifier: "%.2f")")
                        .font(.custom("Irish Grover Regular", size: 18))
                    Text("x \(item.quantity)")
                        .font(.custom("Irish Grover Regular", size: 18))
                }
            }
            
            HStack {
                Text("Subtotal:")
                    .font(.custom("Irish Grover Regular", size: 18))
                Spacer()
                Text("$\(subtotal, specifier: "%.2f")")
                    .font(.custom("Irish Grover Regular", size: 18))
            }
            .padding()
            
            Button(action: {
                // Perform any actions you want to do before navigating
            }) {
                Text("Checkout")
                    .font(.custom("Irish Grover Regular", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            .background(
                NavigationLink(destination: CheckoutView()) {
                    EmptyView()
                }
                .hidden()
            )
            .padding(.horizontal)
            .padding(.bottom, 20)
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
