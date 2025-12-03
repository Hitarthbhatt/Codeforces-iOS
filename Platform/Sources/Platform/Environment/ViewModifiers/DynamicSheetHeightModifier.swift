//
//  DynamicSheetHeightModifier.swift
//  Platform
//
//  Created by Ankit Panchotiya on 23/02/25.
//

import SwiftUI

struct SheetHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct DynamicSheetHeightModifier: ViewModifier {
    @State private var height: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: SheetHeightPreferenceKey.self, value: geometry.size.height)
                        .onPreferenceChange(SheetHeightPreferenceKey.self) { newHeight in
                            height = newHeight
                        }
                }
            }
            .presentationDetents([.height(height)])
    }
}

public extension View {
    func dynamicSheetHeight() -> some View {
        self.modifier(DynamicSheetHeightModifier())
    }
}
