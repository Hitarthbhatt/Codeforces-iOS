//
//  ADMenuListView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 10/02/25.
//

import Foundation
import SwiftUI

public struct ADMenuListView<Content: View>: View {

    public let menuItems: [MenuItemDTO]
    private let content: Content

    public init(
        menuItems: [MenuItemDTO],
        @ViewBuilder content: () -> Content
    ) {
        self.menuItems = menuItems
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            Menu {
                ForEach(menuItems) { menuItem in
                    Button {
                        menuItem.action()
                    } label: {
                        Text(menuItem.title)
                    }
                }
            } label: {
                content
            }
        }
    }
}

#Preview {
    ADMenuListView(menuItems: [.init(title: "", action: {
    })]) {
        
    }
}
