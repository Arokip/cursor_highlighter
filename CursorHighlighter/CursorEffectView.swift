import SwiftUI

struct CursorEffectView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.teal, lineWidth: 4)
                .frame(width: 200, height: 200)
                .scaleEffect(isAnimating ? 1.0 : 0.1)
                .opacity(isAnimating ? 0.0 : 1.0)
        }
        // FIX 4: Ignore Safe Area to ensure the circle is truly centered in the window
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Force fill
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimating = true
            }
        }
    }
}
