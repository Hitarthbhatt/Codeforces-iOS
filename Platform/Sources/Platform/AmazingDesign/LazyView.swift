//
//  LazyView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 30/10/25.
//

import SwiftUI

public struct LazyView<Content: View>: View {
    let build: () -> Content

    public init(build: @escaping () -> Content) {
        self.build = build
    }

    public var body: some View {
        build()
    }
}
