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
                    Text("Main Page")
                        .font(.title)
                        .padding()
                    
                    NavigationLink(destination: ItemSelectionView()) {
                        Text("Select Items")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    .padding()
                }
                .navigationTitle("My App")
            }
        }
    }
}
