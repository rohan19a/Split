//
//  SignupView.swift
//  Split
//
//  Created by Rohan Agrawal on 3/25/23.
//

import Foundation
import SwiftUI
import Firebase

struct SignupView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    let backgroundColor = Color(red:220/255, green:242/255, blue:255/255)
    var body: some View {
        VStack {
            let textFieldColor = Color(red: 217/255, green: 217/255, blue: 217/255)
            let buttonColor = Color(red: 240/255, green: 217/255, blue: 217/255)
            Text("Sign up").font(.largeTitle)

            TextField("Name", text: $email)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)
            
            TextField("Username", text: $email)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)

            SecureField("Password", text: $password)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)

            SecureField("Confirm Password", text: $password)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)

            Button("Sign up") {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        // User signed up successfully
                        let db = Firestore.firestore()
                        db.collection("users").document(authResult!.user.uid).setData(["email": email])
                    }
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(buttonColor)
            .cornerRadius(100.0)

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding().background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}
struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
