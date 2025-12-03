//
//  ShimmerEffect.swift

import SwiftUI

public struct ShimmerEffect {
    public var animation: Animation
    public var gradient: Gradient
    public var bandSize: CGFloat
    
    /// The default animation effect.
    static public let defaultAnimation = Animation.linear(duration: 1.5).delay(0.25).repeatForever(autoreverses: false)

    // A default gradient for the animated mask.
    static public let defaultGradient = Gradient(colors: [
        Color.black, // translucent
        .black, // opaque
        Color.gray // translucent
    ])
    
    public init(
        animation: Animation = ShimmerEffect.defaultAnimation,
        gradient: Gradient = ShimmerEffect.defaultGradient,
        bandSize: CGFloat = 0.3
    ) {
        self.animation = animation
        self.gradient = gradient
        self.bandSize = bandSize
    }
}

struct Shimmer: ViewModifier {
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    init(_ shimmerEffect: ShimmerEffect) {
        self.animation = shimmerEffect.animation
        self.gradient = shimmerEffect.gradient
        // Calculate unit point dimensions beyond the gradient's edges by the band size
        self.min = 0 - shimmerEffect.bandSize
        self.max = 1 + shimmerEffect.bandSize
    }

    /// The start unit point of our gradient, adjusting for layout direction.
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    /// The end unit point of our gradient, adjusting for layout direction.
    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    public func body(content: Content) -> some View {
        content
            .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
            .animation(animation, value: isInitialState)
            .onAppear {
                // Delay the animation until the initial layout is established
                // to prevent animating the appearance of the view
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    isInitialState = false
                }
            }
    }
}

extension View {
    @ViewBuilder func shimmering(_ shimmerEffect: ShimmerEffect) -> some View {
        modifier(Shimmer(shimmerEffect))
    }
}
