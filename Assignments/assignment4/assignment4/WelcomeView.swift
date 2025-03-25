//
//  WelcomeView.swift
//  assignment4
//
//  Created by Sam Jin on 3/20/25.
//

import SwiftUI

struct WelcomeView: View {
    let startQuiz: () -> Void
    
    var body: some View {
        VStack {
            Text("Quizzo")
                .font(.largeTitle)
                .padding()
            Button(action: startQuiz) {
                Text("Begin")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .transition(.scale)
    }
}
