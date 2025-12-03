//
//  LoadingManager.swift
//  Platform
//
//  Created by Ankit Panchotiya on 20/02/25.
//

import SwiftUI

@Observable
final public class LoadingManager {
    public var loadingStates: [String: Bool] = [:]
    
    public init() {}
    
    public func showLoader(for id: String) {
        DispatchQueue.main.async {
            self.loadingStates[id] = true
        }
    }
    
    public func hideLoader(for id: String) {
        DispatchQueue.main.async {
            self.loadingStates[id] = false
        }
    }
    
    public func isLoading(id: String) -> Bool {
        return loadingStates[id] ?? false
    }
}
