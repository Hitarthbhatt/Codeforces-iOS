//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 16/02/25.
//

import SwiftUI

public struct AnyRoutingDestination: Hashable {
    private let id: UUID
    private let _navigateDestination: () -> AnyView
    
    public init<T: RoutingDestinationProtocol>(_ destination: T) {
        self.id = destination.id
        self._navigateDestination = { AnyView(destination.navigateDestination()) }
    }
    
    public func navigateDestination() -> AnyView {
        _navigateDestination()
    }
    
    public static func == (lhs: AnyRoutingDestination, rhs: AnyRoutingDestination) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
