//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 16/02/25.
//

import SwiftUI

public protocol RoutingDestinationProtocol: Hashable, Equatable {
    associatedtype Body: View
    var id: UUID { get }
    func navigateDestination() -> Self.Body
}

public extension RoutingDestinationProtocol {
    var id: UUID { return .init() }
}
