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
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Text("Sign in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            Button(action: signIn) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.blue)
                    .cornerRadius(15.0)
            }
            .padding(.bottom, 20)
            
            Text(errorMessage)
                .foregroundColor(.red)
            
            NavigationView {
                ZStack {
                    if session.isLogged {
                        ContentView()
                    } else {
                        LoginView()
                    }
                }
                .onAppear(perform: session.listen)
                .navigationViewStyle(StackNavigationViewStyle())
            }


        }
        .padding(.horizontal, 30)
    }
    
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
                self.errorMessage = ""
                // Navigate to next screen after successful login
                self.session.isLogged = true
            }
        }
    }
}

