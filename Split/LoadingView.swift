//
//  LoadingView.swift
//  Split
//
//  Created by Rohan Agrawal on 3/28/23.
//

import Foundation
import SwiftUI
import Firebase

struct LoadingView: View {
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack {
            if isLoading {
                // Show loading spinner or other loading UI
            } else {
                NavigationView {
                    LoginView()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                }
            }
        }
        .onAppear {
            // Check if user is already signed in and set isLoading accordingly
            // Example Firebase code to check for current user
            if Auth.auth().currentUser != nil {
                isLoading = false
            } else {
                isLoading = false
            }
        }
    }
}
