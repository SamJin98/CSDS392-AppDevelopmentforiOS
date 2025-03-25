//
//  QuizView.swift
//  assignment4
//
//  Created by Sam Jin on 3/20/25.
//

import SwiftUI

struct QuizView: View {
    let question: Question
    let selectAnswer: (Int) -> Void
    @Binding var selectedIndex: Int?
    @Binding var isAnimatingCorrect: Bool
    @Binding var isAnimatingWrong: Bool
    @Binding var incorrectIndexes: Set<Int>
    @Binding var isExpandingCorrect: Bool

    var body: some View {
        ZStack {
            VStack {
                Text("Quizzo")
                    .font(.largeTitle)
                    .padding()

                Text(question.text)
                    .font(.title2)
                    .padding()

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<question.answers.count, id: \.self) { index in
                        let isCorrect = index == question.correctAnswer
                        let isSelected = selectedIndex == index

                        Text(question.answers[index])
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 60)
                            .background(
                                isSelected
                                    ? (isCorrect ? Color.green : (isAnimatingWrong ? Color.red : Color.gray.opacity(0.5)))
                                    : Color.gray
                            )
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .scaleEffect(isExpandingCorrect && isSelected ? 20 : 1)
                            .opacity(
                                isExpandingCorrect
                                    ? (isSelected ? 1 : 0)
                                    : 1
                            )
                            .animation(.easeIn(duration: 0.5), value: isExpandingCorrect)
                            .rotationEffect(isAnimatingWrong && isSelected ? Angle(degrees: -10) : .zero)
                            .animation(isAnimatingWrong && isSelected
                                ? Animation.easeInOut(duration: 0.1).repeatCount(3, autoreverses: true)
                                : .default, value: isAnimatingWrong)
                            .onTapGesture {
                                selectAnswer(index)
                            }
                    }
                }
                .padding()
            }
        }
        .background(Color.white)
    }
}

