import SwiftUI

struct OptionRow: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.body)
                    .foregroundColor(textColor)
                Spacer()
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(isCorrect != nil)
    }
    
    private var backgroundColor: Color {
        if isCorrect == true { return Color.green.opacity(0.15) }
        if isSelected && isCorrect == false { return Color.red.opacity(0.15) }
        if isSelected && isCorrect == nil { return Color.blue.opacity(0.1) }
        return Color(uiColor: .tertiarySystemFill)
    }
    
    private var borderColor: Color {
        if isCorrect == true { return .green }
        if isSelected && isCorrect == false { return .red }
        if isSelected && isCorrect == nil { return .blue }
        return .clear
    }
    
    private var textColor: Color {
        if isCorrect == true { return .green }
        if isSelected && isCorrect == false { return .red }
        if isSelected && isCorrect == nil { return .blue }
        return .primary
    }
}
