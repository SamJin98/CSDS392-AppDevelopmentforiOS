//
//  ContentView.swift
//  Spartie
//
//  Created by Sam Jin on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        VStack {
            Image("login") // Ensure "logo.png" is in Assets.xcassets
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
            Text("Spartie")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()

            
            TextField("Enter Username", text: $username)
                .padding(.horizontal, 40)
            
            SecureField("Enter Password", text: $password)
                .padding(.horizontal, 40)
            
            Button("Login"){
                handleLogin()
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 40)
            .padding(.top, 20)
            
        }
        .padding()
    }
    
    func handleLogin() {
        guard !username.isEmpty && !password.isEmpty else {
            print("Username or password cannot be empty")
            return
        }
        
        print("Username: \(username), Password: \(password)")
    }
}

#Preview {
    ContentView()
}
