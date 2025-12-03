//
//  File.swift
//  Platform

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @Environment(ShimmerManager.self) var shimmerManager
    let id: String
    
    func body(content: Content) -> some View {
        content
            .disabled(shimmerManager.isShimmering(id: id))
            .if(shimmerManager.isShimmering(id: id)) { view in
                view
                    .redacted(reason: .placeholder)
                    .shimmering(shimmerManager.shimmerEffect)
            }
    }
}

public extension View {
    func shimmerView(id: String) -> some View {
        self.modifier(ShimmerModifier(id: id))
    }
}
