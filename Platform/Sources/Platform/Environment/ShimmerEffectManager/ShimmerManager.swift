//
//  ShimmerManager.swift
//  Platform

import SwiftUI

@Observable
final public class ShimmerManager {
    
    public var shimmerStates: [String: Bool] = [:]
    public var shimmerEffect: ShimmerEffect = .init()
    
    public init() {}
    
    public func showShimmer(
        for id: String,
        shimmerEffect: ShimmerEffect = .init()
    ) {
        DispatchQueue.main.async {
            self.shimmerStates[id] = true
            self.shimmerEffect = shimmerEffect
        }
    }
    
    public func hideShimmer(for id: String) {
        DispatchQueue.main.async {
            self.shimmerStates[id] = false
        }
    }
    
    public func isShimmering(id: String) -> Bool {
        return shimmerStates[id] ?? false
    }
}
