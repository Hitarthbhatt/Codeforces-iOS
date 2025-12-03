//
//  NavigationTab.swift
//  PairPenguin
//
//  Created by Ankit Panchotiya on 13/10/25.
//

import SwiftUI
import Platform

@MainActor
struct NavigationTab<Content: View>: View {
    @State private var routerService = RouterService.shared
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        NavigationStack(path: $routerService.path) {
            content()
                .withAppRouter()
        }
        .environment(routerService)
    }
}
