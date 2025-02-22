//
//  MessageView.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import SwiftUI

struct MessageView: View {
    @Binding var contact: Contact
    @State private var newMessage = ""
    
    var body: some View {
        VStack {
            ZStack {
                NavigationLink(destination: ProfileView(contact: $contact)) {
                    VStack {
                        ContactRow(contact: contact)
                    }
                }
                .padding(.all, 8)
            }
            Divider()
                .background(Color.gray)
                .shadow(radius: 2)

            List(contact.messages, id: \ .self) { message in
                MessageBubble(message: message)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            HStack {
                TextField("Message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .submitLabel(.send)
                    .onSubmit {
                        sendMessage()
                    }
                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane")
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
        .padding(.top, 10)
    }
    
    private func sendMessage() {
        guard !newMessage.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        contact.messages.append(newMessage)
        newMessage = ""
    }
}

struct MessageBubble: View {
    let message: String
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(message)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
            Text(getDateFormat(for: Date()))
                .foregroundColor(.gray)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.vertical, 4)
    }
}

func getDateFormat(for date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/d/yy, h:mm a"
    return formatter.string(from: date)
}
