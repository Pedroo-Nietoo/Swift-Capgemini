import SwiftUI

struct ProfileView: View {
    @AppStorage("username") private var username: String = ""
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var difficulty: String = "Normal"
    @State private var volume: Double = 50.0
    
    let difficulties = ["Fácil", "Normal", "Difícil"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Perfil do Jogador")) {
                    HStack {
                        Circle()
                            .fill(Color.purple.opacity(0.2))
                            .frame(width: 50, height: 50)
                            .overlay(Image(systemName: "person.fill").foregroundColor(.purple))
                        
                        TextField("Digite seu nome", text: $username)
                    }
                }
                
                Section(header: Text("Configurações")) {
                    Toggle("Modo Escuro", isOn: $isDarkMode)
                    
                    Picker("Dificuldade (não operacional)", selection: $difficulty) {
                        ForEach(difficulties, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Volume dos Efeitos: \(Int(volume))%")
                        Slider(value: $volume, in: 0...100)
                    }
                }
            }
            .navigationTitle("Ajustes")
        }
    }
}
