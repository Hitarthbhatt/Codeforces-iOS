//
//  FirstAppearViewModifier.swift
//  Platform
//
//  Created by Ankit Panchotiya on 24/03/25.
//

import SwiftUI

public struct FirstAppearViewModifier: ViewModifier {
    
    private let action: () async -> Void
    @State private var hasAppeared = false
    
    public init(_ action: @escaping () async -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .task {
                guard !hasAppeared else { return }
                hasAppeared = true
                await action()
            }
    }
}

public extension View {
    func onFirstAppear(_ action: @escaping () async -> Void) -> some View {
        modifier(FirstAppearViewModifier(action))
    }
}
