//
//  ContentView.swift
//  Demo3
//
//  Created by Sam Jin on 1/23/25.
//

import SwiftUI

struct MagicText {
    let text: String
    init(_ text: String) {
        self.text = text
        print("printing \(text)")
    }
}

struct Todo: Identifiable {
    let id = UUID()
    let todo: String
    var name = ""
}

struct ContentView: View {
    @State var everyday = ["Sudy", "Learn", "Run"]
    @State var todos = [String]()
    @State var todo = ""
    var body: some View {
        VStack {
            List {
                Section{
                    ForEach(everyday, id: \.self) { todo in
                        Text(todo)
                    }
                } header: {
                    Text("everyday List")
                }
                
                Section{
                    ForEach(todos, id: \.self) { todo in
                        Text(todo)
                    }
                } header: {
                    Text("Todo List")
                }
            }
            .listStyle(.grouped)
            .refreshable {
                todos.removeAll()
            }
            HStack {
                TextField("add todo", text: $todo)
                Button("Add") {
                    todos.append(todo)
                    todo = ""
            }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
