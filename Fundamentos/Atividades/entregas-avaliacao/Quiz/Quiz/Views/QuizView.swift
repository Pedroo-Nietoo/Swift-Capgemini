import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @Binding var isPlaying: Bool
    @AppStorage("username") private var username: String = ""
    let themeName: String
    
    var isLastQuestion: Bool {
        viewModel.currentQuestionIndex == viewModel.currentQuestions.count - 1
    }
    
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: { isPlaying = false }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    Text(themeName)
                        .font(.title2).bold()
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    Spacer()
                }
                
                let progress = CGFloat(viewModel.currentQuestionIndex + 1) / CGFloat(viewModel.currentQuestions.count)
                ProgressBar(progress: progress)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Pergunta \(viewModel.currentQuestionIndex + 1)/\(viewModel.currentQuestions.count)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.currentQuestions[viewModel.currentQuestionIndex].text)
                        .font(.title3).bold()
                        .foregroundColor(.primary)
                    
                    ForEach(0..<4, id: \.self) { index in
                        if index < viewModel.currentQuestions[viewModel.currentQuestionIndex].options.count {
                            OptionRow(
                                text: viewModel.currentQuestions[viewModel.currentQuestionIndex].options[index],
                                isSelected: viewModel.selectedOptionIndex == index,
                                isCorrect: viewModel.checkAnswer(for: index)
                            ) {
                                if !viewModel.isAnswered {
                                    viewModel.selectedOptionIndex = index
                                }
                            }
                        }
                    }
                }
                .padding()
                .background(Color(uiColor: .secondarySystemGroupedBackground))
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.1), radius: 10)
                
                Spacer()
                
                if !viewModel.isAnswered && viewModel.skipsRemaining > 0 {
                    Button(action: {
                        viewModel.skipQuestion()
                    }) {
                        Text("Pular Pergunta (\(viewModel.skipsRemaining) restantes)")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.bottom, 5)
                }
                
                Button(action: {
                    if viewModel.isAnswered { viewModel.nextQuestion() }
                    else { viewModel.confirmAnswer() }
                }) {
                    Text(viewModel.isAnswered ? (isLastQuestion ? "Finalizar" : "Próxima Pergunta") : "Confirmar Resposta")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.selectedOptionIndex != nil ? Color.blue : Color.white.opacity(0.3))
                        .cornerRadius(30)
                }
                .disabled(viewModel.selectedOptionIndex == nil && !viewModel.isAnswered)
            }
            .padding()
        }
        .alert(isPresented: $viewModel.showAlert) {
            let displayName = username.isEmpty ? "Jogador" : username
            
            return Alert(
                title: Text("Fim de Jogo, \(displayName)!"),
                message: Text("Você acertou \(viewModel.score) de \(viewModel.currentQuestions.count) perguntas."),
                dismissButton: .default(Text("Voltar aos Temas")) {
                    isPlaying = false
                }
            )
        }
        .navigationBarHidden(true)
    }
}
