//
//  CheckoutView.swift
//  Split
//
//  Created by Rohan Agrawal on 4/18/23.
//

//
//  ShoppingView.swift
//  Split
//
//  Created by Rohan Agrawal on 4/18/23.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Checkout")
                .font(.largeTitle)
                .padding()
            Form {
                Section(header: Text("Shipping Address")) {
                    TextField("Full Name", text: .constant(""))
                    TextField("Address", text: .constant(""))
                    TextField("City", text: .constant(""))
                    TextField("State", text: .constant(""))
                    TextField("Zip Code", text: .constant(""))
                }
                
                Section(header: Text("Payment Method")) {
                    Picker(selection: .constant(0), label: Text("Payment Method")) {
                        Text("Credit Card").tag(0)
                        Text("PayPal").tag(1)
                    }
                    
                    if true {
                        // Show Credit Card Input
                        TextField("Card Number", text: .constant(""))
                        TextField("Expiration Date", text: .constant(""))
                        TextField("CVV", text: .constant(""))
                    }
                }
            }
                
                Section {
                    Button(action: {}) {
                        Text("Place Order")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
        )
    }
