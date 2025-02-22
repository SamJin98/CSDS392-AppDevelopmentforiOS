//
//  ContentView.swift
//  Demo2
//
//  Created by Sam Jin on 1/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var greetings = ""
    var body: some View {
        VStack{
            Spacer()
            Text("Hello, world!")
                .font(.largeTitle)
                .frame(width:200, height:200)
                .background(Color.purple)
                .border(Color.black)
                .cornerRadius(20)
            Spacer()
            HStack{
                Text("Greeting")
                TextField("Enter text", text:$greetings)
            }
            Spacer()
            Button("Send Greeting \(greetings)") {
                print("Button pressed: \(greetings)")
            }
            .buttonStyle(.borderedProminent)
        }.padding()
    }
}

#Preview("Primary") {
    ContentView()
}

#Preview {
    ContentView()
}
