import Foundation

struct Theme: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let icon: String
    let questions: [Question]
}

struct Question: Codable, Hashable {
    let text: String
    let options: [String]
    let correctAnswerIndex: Int
}
