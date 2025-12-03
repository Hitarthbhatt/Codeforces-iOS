//
//  RouterService.swift

import SwiftUI
import Combine

@Observable
final public class RouterService {

    static public let shared: RouterService = .init()

    public var path: [AnyRoutingDestination] = []

    public func navigateTo<T: RoutingDestinationProtocol>(route: T) {
        self.path.append(AnyRoutingDestination(route))
    }

    public func popView() {
        guard path.isNotEmpty else { return }
        self.path.removeLast()
    }

    public func popToRoot() {
        guard path.isNotEmpty else { return }
        self.path.removeAll()
    }
}

extension RouterService {
    @ViewBuilder public func navigationDestination(_ destination: AnyRoutingDestination) -> some View {
        destination.navigateDestination()
    }
}
