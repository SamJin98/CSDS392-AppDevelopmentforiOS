//
//  ContentView.swift
//  Demo6
//
//  Created by Sam Jin on 3/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteMovies = ["A", "B", "C"]
    @State private var movie: String = ""
    @State private var scale = 1.0
    @State private var spinTime = 1.0
    
    @State private var isExpanded = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1.0) {
            
            HStack {
                Button("", systemImage: "") {
                    
                }
                Text("Animation Notes")
                    .font(.headline)
                Spacer()
            }
            Text("these are primitive animations in SwiftUI (not UIKit) - they are very fast and easy to create")
        }
        .padding()
        
        Divider()
        
        VStack(alignment: .leading, spacing: 1.0) {
            HStack {
                Text("Animation Notes")
                    .font(.headline)
                Button(action: {
                    withAnimation(.easeInOut) {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "arrow.down" : "arrow.right")
                }
                Spacer()

            }
            if isExpanded {
                Text("these are primitive animations in SwiftUI (not UIKit) - they are very fast and easy to create")
                    .transition(.opacity)
            }
        }
        .padding()
        Divider()
        
        
        VStack {
            Text("Favorite Movies")
                .font(.largeTitle)
            List(favoriteMovies, id: \.self) {movie in
                Text(movie)
            }
            Spacer()
            HStack {
                TextField("Add Movie", text: $movie)
                    .scaleEffect(scale, anchor: .leading)
                Button("Add"){
                    if (movie.isEmpty) {
                        withAnimation(.easeIn) {
                            scale = 2.0
                            spinTime -= 0.1
                        } completion: {
                            withAnimation {
                                scale = 1.0
                            }
                        }
                        
                        scale = 2.0
                    } else {
                        withAnimation {
                            favoriteMovies.append(movie)
                            movie = ""
                        }
                    }
                }
                .rotation3DEffect(.degrees(360 + spinTime), axis: (x:1, y:0, z:1))
                .animation(.default)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
