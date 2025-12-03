//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 16/02/25.
//

import SwiftUI

@MainActor
public extension View {
    func withAppRouter() -> some View {
        navigationDestination(for: AnyRoutingDestination.self) { destination in
            RouterService.shared.navigationDestination(destination)
        }
    }
}
