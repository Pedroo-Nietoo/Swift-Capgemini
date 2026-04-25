import Foundation
import SwiftUI
import Combine

class QuizViewModel: ObservableObject {
    @Published var themes: [Theme] = []
    @Published var currentQuestions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedOptionIndex: Int? = nil
    @Published var isAnswered = false
    @Published var score = 0
    @Published var showAlert = false
    
    @Published var skipsRemaining = 2
    
    init() {
        self.themes = DataLoader.loadThemes()
    }
    
    func startQuiz(theme: Theme) {
        self.currentQuestions = Array(theme.questions.shuffled().prefix(5))
        self.currentQuestionIndex = 0
        self.score = 0
        self.skipsRemaining = 2
        self.resetTurn()
    }
    
    func skipQuestion() {
        guard skipsRemaining > 0 else { return }
        skipsRemaining -= 1
        
        if currentQuestionIndex < currentQuestions.count - 1 {
            currentQuestionIndex += 1
            resetTurn()
        } else {
            showAlert = true
        }
    }
    
    func confirmAnswer() {
        guard let selected = selectedOptionIndex else { return }
        isAnswered = true
        if selected == currentQuestions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex < currentQuestions.count - 1 {
            currentQuestionIndex += 1
            resetTurn()
        } else {
            showAlert = true
        }
    }
    
    func checkAnswer(for index: Int) -> Bool? {
        guard isAnswered else { return nil }
        let correctIndex = currentQuestions[currentQuestionIndex].correctAnswerIndex
        if index == correctIndex { return true }
        if index == selectedOptionIndex && index != correctIndex { return false }
        return nil
    }
    
    private func resetTurn() {
        selectedOptionIndex = nil
        isAnswered = false
    }
}
