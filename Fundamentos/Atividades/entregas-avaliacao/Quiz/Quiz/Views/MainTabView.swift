import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = QuizViewModel()
    @State private var isPlaying = false
    @State private var selectedTheme: Theme?
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        TabView {
            NavigationStack {
                List(viewModel.themes) { theme in
                    Button(action: {
                        selectedTheme = theme
                        viewModel.startQuiz(theme: theme)
                        isPlaying = true
                    }) {
                        HStack {
                            Image(systemName: theme.icon)
                                .foregroundColor(.blue)
                                .font(.title2)
                                .frame(width: 40)
                            Text(theme.name)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle("Escolha um Tema")
                .navigationDestination(isPresented: $isPlaying) {
                    if let theme = selectedTheme {
                        QuizView(viewModel: viewModel, isPlaying: $isPlaying, themeName: theme.name)
                    }
                }
            }
            .tabItem {
                Label("Jogar", systemImage: "gamecontroller.fill")
            }
            
            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
