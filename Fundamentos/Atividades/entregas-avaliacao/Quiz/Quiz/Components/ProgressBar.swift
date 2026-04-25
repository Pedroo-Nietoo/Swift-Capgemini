import SwiftUI

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 12)
                
                Capsule()
                    .fill(Color.green)
                    .frame(width: geometry.size.width * progress, height: 12)
                    .animation(.spring(), value: progress)
            }
        }
        .frame(height: 12)
    }
}
