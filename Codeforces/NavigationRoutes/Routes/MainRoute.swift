//
//  MainRoute.swift

import SwiftUI
import Platform

enum MainRoute: Hashable, RoutingDestinationProtocol {

    case none
    
    @ViewBuilder
    func navigateDestination() -> some View {
        switch self {
        case .none:
            EmptyView()
        }
    }
}
