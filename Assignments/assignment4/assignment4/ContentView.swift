//
//  ContentView.swift
//  assignment4
//
//  Created by Sam Jin on 3/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var questions: [Question] = [
        Question(text: "In SwiftUI, which type of stack is used for layering views on top of each other?",
                 answers: ["ZStack", "VStack", "LStack", "HStack"], correctAnswer: 0),
        Question(text: "Which SwiftUI stack arranges views horizontally?",
                 answers: ["HStack", "VStack", "ZStack", "LStack"], correctAnswer: 0),
        Question(text: "Which framework is used for building iOS user interfaces?",
                 answers: ["UIKit", "SwiftUI", "React", "Flutter"], correctAnswer: 1),
        Question(text: "What is Swift primarily used for?",
                 answers: ["Web Development", "Mobile Development", "Data Science", "Game Design"], correctAnswer: 1)
    ].shuffled()
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var incorrectCount = 0
    @State private var showWelcome = true
    @State private var selectedIndex: Int? = nil
    @State private var showResults = false
    @State private var isAnimatingCorrect = false
    @State private var isAnimatingWrong = false
    @State private var incorrectIndexes: Set<Int> = []
    @State private var isExpandingCorrect = false

    var body: some View {
        VStack {
            if showWelcome {
                WelcomeView(startQuiz: {
                    withAnimation(.easeInOut) {
                        showWelcome = false
                    }
                })
            } else if showResults {
                ResultsView(score: score, incorrectCount: incorrectCount, totalQuestions: questions.count, restartQuiz: restartQuiz)
            } else {
                QuizView(
                    question: questions[currentQuestionIndex],
                    selectAnswer: handleAnswer,
                    selectedIndex: $selectedIndex,
                    isAnimatingCorrect: $isAnimatingCorrect,
                    isAnimatingWrong: $isAnimatingWrong,
                    incorrectIndexes: $incorrectIndexes,
                    isExpandingCorrect: $isExpandingCorrect
                )
            }
        }
    }
    
    private func handleAnswer(index: Int) {
        selectedIndex = index
        if index == questions[currentQuestionIndex].correctAnswer {
            if !incorrectIndexes.contains(index) {
                score += 1
            }
            isExpandingCorrect = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isExpandingCorrect = false
                incorrectIndexes.removeAll()
                nextQuestion()
            }
        } else {
            isAnimatingWrong = true
            incorrectIndexes.insert(index)
            incorrectCount += 1

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimatingWrong = false
                selectedIndex = nil
            }  
        }
    }

    
    private func nextQuestion() {
        selectedIndex = nil
        incorrectIndexes.removeAll()
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResults = true
        }
    }
    
    private func restartQuiz() {
        score = 0
        incorrectCount = 0
        currentQuestionIndex = 0
        showResults = false
        questions.shuffle()
        showWelcome = true
        incorrectIndexes.removeAll()
    }
}

#Preview {
    ContentView()
}
