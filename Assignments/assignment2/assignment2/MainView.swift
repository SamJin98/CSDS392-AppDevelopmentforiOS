//
//  MainView.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import SwiftUI

struct MainView: View {
    @State private var contacts = [
        Contact(firstName: "Test", lastName: "User1", image: "profile2", isFavorite: true, messages: []),
        Contact(firstName: "Test", lastName: "User2", image: "profile", isFavorite: true, messages: []),
        Contact(firstName: "Test", lastName: "User3", image: nil, isFavorite: false, messages: [])
    ]
    @State private var showAddContact = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts.indices, id: \ .self) { index in
                    NavigationLink(destination: MessageView(contact: $contacts[index])) {
                        ContactRow(contact: contacts[index])
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button(action: { showAddContact = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddContact) {
                AddContactView(contacts: $contacts)
            }
        }
    }
}

#Preview {
    MainView()
}
