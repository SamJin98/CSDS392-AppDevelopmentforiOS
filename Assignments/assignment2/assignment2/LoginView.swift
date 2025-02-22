//
//  LoginView.swift
//  assignment2
//
//  Created by Sam Jin on 2/18/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("Login").font(.largeTitle)
            TextField("Username", text: $username).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            if showError {
                Text("Invalid credentials").foregroundColor(.red)
            }
            
            Button("Sign In") {
                if username.lowercased() == "spartie" && password.lowercased() == "messages" {
                    isLoggedIn = true
                } else {
                    showError = true
                }
            }.padding()
        }
        .padding()
    }
}

