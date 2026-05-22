import Foundation

class ViaCEPService {
    func fetchAddress(cep: String) async throws -> ViaCEPResponse {
        let cleanCEP = cep.replacingOccurrences(of: "-", with: "")
        guard let url = URL(string: "https://viacep.com.br/ws/\(cleanCEP)/json/") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ViaCEPResponse.self, from: data)
    }
}
