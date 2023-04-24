//
//  LoginView.swift
//  Split
//
//  Created by Rohan Agrawal on 3/21/23.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class SessionStore: ObservableObject {
    @Published var currentUser: User?
    @Published var isLogged: Bool = false
    var handle: AuthStateDidChangeListenerHandle?

    func listen() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                //self.currentUser = user
                self.isLogged = true
            } else {
                self.currentUser = nil
                self.isLogged = false
            }
        }
    }


    func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.isLogged = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    deinit {
        // Stop listening for authentication state changes.
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    let backgroundColor = Color(red:220/255, green:242/255, blue:255/255)
    var body: some View {

        VStack {
            
            let textFieldColor = Color(red: 217/255, green: 217/255, blue: 217/255)
            let buttonColor = Color(red: 240/255, green: 217/255, blue: 217/255)
            Text("SplitShopp")
                .frame(width: 300, height: 100)
                .padding(.bottom, 50).font(.system(size:60.0))
            
            TextField("Username", text: $email)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(textFieldColor)
                .padding(.bottom, 20)
            
            Button(action: {

            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(buttonColor)
                    .cornerRadius(100.0)
            }
            Button(action: {

            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .   background(buttonColor)
                    .cornerRadius(100.0)
            }
        }
        .padding().background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
