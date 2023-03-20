//
//  ContentView.swift
//  Split
//
//  Created by Rohan Agrawal on 3/16/23.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Forum")
                    .font(.title)
                    .padding()
                
                NavigationLink(destination: NewPostView()) {
                    Text("New Post")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                .padding()
                
                List {
                    ForEach(1...10, id: \.self) { index in
                        NavigationLink(destination: PostDetailView()) {
                            Text("Post \(index)")
                        }
                    }
                }
            }
            .navigationTitle("Forum")
        }
    }
}

struct NewPostView: View {
    var body: some View {
        Text("New Post View")
            .navigationTitle("New Post")
    }
}

struct PostDetailView: View {
    var body: some View {
        Text("Post Detail View")
            .navigationTitle("Post Detail")
    }
}


struct ItemSelectionView: View {
    @State private var searchText = ""
    @State private var selectedItems = Set<String>()
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 10"]
    
    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding()
                
                List(filteredItems, id: \.self) { item in
                    ItemRow(item: item, isSelected: selectedItems.contains(item))
                        .onTapGesture {
                            if selectedItems.contains(item) {
                                selectedItems.remove(item)
                            } else {
                                selectedItems.insert(item)
                            }
                        }
                }
                .navigationBarTitle("Item Selection")
                .navigationBarItems(trailing:
                    Button(action: {
                        print("Selected items: \(selectedItems)")
                    }) {
                        Text("Done")
                    }
                )
            }
        }
    }
}

struct ItemRow: View {
    let item: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(item)
            
            if isSelected {
                Spacer()
                
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

