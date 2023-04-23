//
//  CheckoutView.swift
//  testing
//
//  Created by Rohan Agrawal on 4/18/23.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedPaymentMethod = 0
    
    var subtotal = 150.0
    var taxes = 10.0
    var fees = 5.0
    
    var total: Double {
        subtotal + taxes + fees
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Checkout
                Text("Checkout")
                    .font(.custom("Irish Grover Regular", size: 64))
                    .foregroundColor(Color(#colorLiteral(red: 0.69, green: 0.49, blue: 0.49, alpha: 1)))
                
                HStack {
                    Text("Subtotal:")
                        .font(.custom("Irish Grover Regular", size: 18))
                    Spacer()
                    Text("$\(subtotal, specifier: "%.2f")")
                        .font(.custom("Irish Grover Regular", size: 18))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Taxes:")
                        .font(.custom("Irish Grover Regular", size: 18))
                    Spacer()
                    Text("$\(taxes, specifier: "%.2f")")
                        .font(.custom("Irish Grover Regular", size: 18))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Fees:")
                        .font(.custom("Irish Grover Regular", size: 18))
                    Spacer()
                    Text("$\(fees, specifier: "%.2f")")
                        .font(.custom("Irish Grover Regular", size: 18))
                }
                .padding(.horizontal)
                
                Divider()
                
                HStack {
                    Text("Total:")
                        .font(.custom("Irish Grover Regular", size: 18))
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(total, specifier: "%.2f")")
                        .font(.custom("Irish Grover Regular", size: 18))
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Section(header: Text("Payment Method")
                    .font(.custom("Irish Grover Regular", size: 36))) {
                        Picker(selection: $selectedPaymentMethod, label: Text("Payment Method")) {
                            Text("Credit Card").tag(0)
                                .font(.custom("Irish Grover Regular", size: 18))
                        }
                        if selectedPaymentMethod == 0 {
                            // Show Credit Card Input
                            TextField("Card Number", text: .constant(""))
                                .font(.custom("Irish Grover Regular", size: 18))
                            TextField("Expiration Date", text: .constant(""))
                                .font(.custom("Irish Grover Regular", size: 18))
                            TextField("CVV", text: .constant(""))
                                .font(.custom("Irish Grover Regular", size: 18))
                        }
                    }
                    .padding(.horizontal)
                
                Section {
                    Button(action: {}) {
                        Text("Pay")
                            .foregroundColor(.white)
                            .font(.custom("Irish Grover Regular", size: 18))
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
    
           


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
