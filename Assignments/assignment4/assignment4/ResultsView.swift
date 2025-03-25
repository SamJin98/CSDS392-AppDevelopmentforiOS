//
//  ResultsView.swift
//  assignment4
//
//  Created by Sam Jin on 3/20/25.
//

import SwiftUI

struct ResultsView: View {
    let score: Int
    let incorrectCount: Int
    let totalQuestions: Int
    let restartQuiz: () -> Void
    
    var body: some View {
        VStack {
            Text("Quizzo")
                .font(.largeTitle)
                .padding()
            
            Divider()
            
            Text("Quiz Results")
                .font(.headline)
                .padding()
        
            
            if incorrectCount == 0 {
                Text("Congrats! You got all answers correct!")
                    .padding()
            } else {
                Text("Wrong Attempts: \(incorrectCount)")
                    .font(.title3)
                    .foregroundColor(.red)
                    .padding()
                Text("Keep trying! You can do better!")
                    .padding()
            }
            
            Divider()
            
            Button(action: restartQuiz) {
                Text("Try Again")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .padding()
        }
    }
}
