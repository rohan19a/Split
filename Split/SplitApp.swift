//
//  SplitApp.swift
//  Split
//
//  Created by Rohan Agrawal on 3/16/23.
//

import SwiftUI

@main
struct SplitApp: App {
    var body: some Scene {
        WindowGroup {
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
