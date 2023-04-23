import SwiftUI
import Firebase

struct CartView: View {
    @State var cartItems: [CartItem] = []
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
        .onAppear {
            fetchCartItems()
        }
    }
    
    private func fetchCartItems() {
        let db = Firestore.firestore()
        db.collection("cartItems").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching cart items: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            cartItems = snapshot.documents.compactMap { document in
                guard let data = document.data(),
                      let name = data["name"] as? String,
                      let price = data["price"] as? Double,
                      let quantity = data["quantity"] as? Int else {
                    return nil
                }
                
                return CartItem(name: name, price: price, quantity: quantity)
            }
        }
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
