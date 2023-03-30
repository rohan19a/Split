//
//  MessagingView.swift
//  Split
//
//  Created by Rohan Agrawal on 3/25/23.
//

import Foundation
import SwiftUI
import Firebase

struct Message: Identifiable {
    var id = UUID()
    var senderId: String
    let senderName: String
    let text: String
    let sentAt: Date
}


struct MessagingView: View {
    @ObservedObject var viewModel: MessagingViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Messaging").font(.largeTitle)
                Spacer()
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                }
            }
            .padding(.horizontal)

            List($viewModel.messages) { $message in
                MessageRow(message: $message.wrappedValue, isCurrentUser: message.senderId == viewModel.currentUser?.uid)
            }
            .listStyle(PlainListStyle())

            HStack {
                TextField("Type your message...", text: $viewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            viewModel.connect()
        }
        .onDisappear {
            viewModel.disconnect()
        }
    }
}

struct MessageRow: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }

            VStack(alignment: .leading) {
                Text(message.senderName)
                    .font(.headline)
                Text(message.text)
            }
            .padding(8)
            .foregroundColor(isCurrentUser ? .white : .primary)
            .background(isCurrentUser ? Color.blue : Color(.systemGray5))
            .cornerRadius(10)

            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

class MessagingViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText: String = ""
    
    private var listener: ListenerRegistration?
    private let db = Firestore.firestore()
    public let currentUser = Auth.auth().currentUser
    
    func connect() {
        guard currentUser != nil else { return }
        
        listener = db.collection("messages")
            .order(by: "sentAt", descending: false)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                self.messages = documents.map { document in
                    let data = document.data()
                    let senderId = data["senderId"] as! String
                    let senderName = data["senderName"] as! String
                    let text = data["text"] as! String
                    let sentAt = (data["sentAt"] as! Timestamp).dateValue()
                    
                    return Message(senderId: senderId, senderName: senderName, text: text, sentAt: sentAt)
                }
            }
    }
    
    func disconnect() {
        listener?.remove()
    }
    
    func sendMessage() {
        guard let currentUser = currentUser else { return }
        
        let data: [String: Any] = [
            "senderId": currentUser.uid,
            "senderName": currentUser.displayName ?? "",
            "text": newMessageText,
            "sentAt": Timestamp()
        ]
        
        db.collection("messages").addDocument(data: data) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                self.newMessageText = ""
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let _ as NSError {
            print("Error signing out")
        }
    }
}
