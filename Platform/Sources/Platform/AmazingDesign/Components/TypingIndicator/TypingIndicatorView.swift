import SwiftUI

public struct TypingIndicatorView: View {
    @State private var animationCycle = 0
    @State private var timer: Timer?

    public var animationDuration: Double
    public var dotSize: CGFloat
    public var color: Color

    public init(
        animationDuration: Double = 0.6,
        dotSize: CGFloat = 8,
        color: Color = .secondaryBG
    ) {
        self.animationDuration = animationDuration
        self.dotSize = dotSize
        self.color = color
    }

    public var body: some View {
        HStack(spacing: dotSize) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(color)
                    .frame(width: dotSize, height: dotSize)
                    .offset(y: animationCycle == index ? -dotSize : 0)
            }
        }
        .onAppear {
            animationCycle = 0
            timer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
                // This closure is NOT async, cannot use 'await'
                // But you can dispatch to main if needed
                DispatchQueue.main.async {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        animationCycle = (animationCycle + 1) % 3
                    }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    TypingIndicatorView()
}
