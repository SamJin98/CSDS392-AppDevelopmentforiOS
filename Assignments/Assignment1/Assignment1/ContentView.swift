//
//  ContentView.swift
//  Assignment1 -
//
//  Created by Ruilin Jin on 1/26/25.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let message: String
    let date: Date
    
    init(_ message: String) {
        self.message = message
        self.date = Date()
    }
}

func getDateFormat(for date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "M/d/yy, h:mm a"
    return formatter.string(from: date)
}

struct MessageView: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            // message
            Text(message.message)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.blue)
                .cornerRadius(8)
            
            // date
            Text(getDateFormat(for: message.date))
                .foregroundColor(.gray)
                .font(.caption)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.vertical, 4)
    }
}

struct ContentView: View {
    // mock data
    @State private var messages: [Message] = [
        Message("Hello?"),
        Message("Is this thing on?"),
        Message("I would like to create an app that is useful for people"),
        Message("Maybe an app where people on campus can chat with each other?")
    ]
    
    @State private var newMessage: String = ""
    
    var body: some View {
        VStack {
            List(messages) { message in
                MessageView(message: message)
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
        let msg = Message(newMessage)
        print(messages)
        messages.append(msg)
        newMessage = ""
    }
}

#Preview {
    ContentView()
}
