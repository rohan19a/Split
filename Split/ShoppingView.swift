//
//  ShoppingView.swift
//  Split
//
//  Created by Rohan Agrawal on 4/18/23.
//

import SwiftUI
struct Shopping: Identifiable{
    var id: ObjectIdentifier
    let Appliances: String
    let Groceries: String
    let Furniture: String
    let Clothing: String
    let Electronics: String
}
struct ShoppingView: View {
    
    //@ObservedObject var viewModel = ShoppingviewModel()
    @State private var newMessageText = ""

    var body: some View{
        VStack{
            HStack{
                Text("Shopping").font(.custom("Irish Grover Regular", size: 64)).foregroundColor(Color(#colorLiteral(red: 0.69, green: 0.49, blue: 0.49, alpha: 1)))
                Spacer()
                TextField("search", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }
            HStack{
                Text("Popular Categories").font(.custom("Irish Grover Regular", size: 32)).foregroundColor(Color(#colorLiteral(red: 0.69, green: 0.49, blue: 0.49, alpha: 1)))
                Spacer()
        
                Button("Appliances"){
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                    .frame(width: 328, height: 89)
                    .rotationEffect(.degrees(0.51))
                }
                
                Button(action: {
                    print("press button")
                }) {
                    Text("Groceries")
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                    .frame(width: 328, height: 89)
                    .rotationEffect(.degrees(0.51))
                }
                Button(action: {
                    print("press button")
                }) {
                    Text("Furniture")
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                        .frame(width: 328, height: 89)
                        .rotationEffect(.degrees(0.51))
                    }
                Button(action: {
                    print("press button")
                    }) {
                        Text("Clothing")
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                        .frame(width: 328, height: 89)
                        .rotationEffect(.degrees(0.51))
                    }
                Button(action: {
                    print("press button")
                }) {
                    Text("Electronics")
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                        .frame(width: 328, height: 89)
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                    .frame(width: 328, height: 89)
                    .rotationEffect(.degrees(0.51))
                }
                Button(action: {
                    print("press view cart")
                }) {
                    Text("view cart")
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 1)))
                    .frame(width: 328, height: 89)
                    .rotationEffect(.degrees(0.51))
                }
            }
        }
    }
    
}
struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView()
    }
}
