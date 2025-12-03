//
//  NetworkReachability.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation
import Network

public final class NetworkReachability: ObservableObject {

    // MARK: - Internal stored properties
    static let shared = NetworkReachability()

    // MARK: - Private stored properties
    @Published private(set) var connected: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    // MARK: - Private methods
    private init() {
        checkConnection()
    }
    
    private func checkConnection() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.connected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
