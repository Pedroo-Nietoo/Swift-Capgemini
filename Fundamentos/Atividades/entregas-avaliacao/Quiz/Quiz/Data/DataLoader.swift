import Foundation

class DataLoader {
    static func loadThemes() -> [Theme] {
        guard let url = Bundle.main.url(forResource: "quiz-data", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Erro ao carregar o arquivo JSON.")
            return []
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode([Theme].self, from: data)
        } catch {
            print("Erro ao decodificar JSON: \(error)")
            return []
        }
    }
}
