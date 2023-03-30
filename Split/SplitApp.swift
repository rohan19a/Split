//
//  SplitApp.swift
//  Split
//
//  Created by Rohan Agrawal on 3/16/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct SplitApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            LoadingView()
            NavigationView {
                VStack {
                    NavigationLink(destination: LoginView()) {
                        Text("Login")
                    }
                    .padding().background(Color.blue).foregroundColor(.white).cornerRadius(5)
                    NavigationLink(destination: SignupView()) {
                        Text("Register")
                    }.padding().background(Color.blue).foregroundColor(.white).cornerRadius(5)
                }
                .navigationTitle("My App")
            }
        }
    }
}
