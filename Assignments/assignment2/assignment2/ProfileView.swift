//
//  ProfileView.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//
import SwiftUI


struct ProfileView: View {
    @Binding var contact: Contact
    
    var body: some View {
        VStack {
            Image(contact.image ?? "default")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 2))
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("First Name")
                    .font(.headline)
                TextField("First Name", text: $contact.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Last Name")
                    .font(.headline)
                TextField("Last Name", text: $contact.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Toggle("Is Favorite", isOn: $contact.isFavorite)
                        .labelsHidden()
                    Text("Is Favorite")
                        .font(.headline)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}
