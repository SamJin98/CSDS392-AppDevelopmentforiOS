//
//  AddContact.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import SwiftUI

struct AddContactView: View {
    @Binding var contacts: [Contact]
    @Environment(\.presentationMode) var presentationMode
    @State private var newContact = Contact(firstName: "", lastName: "", image: nil, isFavorite: false, messages: [])
    
    var body: some View {
        NavigationStack {
            ProfileView(contact: $newContact)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            contacts.append(newContact)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        }
    }
}
