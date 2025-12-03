//
//  ADIconButton.swift

import SwiftUI

public struct ADIconButton: View {
    private var symbolName: String
    private var symbolVariant: SymbolVariants
    private var icon: ADIcon
    private var size: CGFloat
    private var foregroundColor: Color
    private var action: () -> Void
    
    public init(icon: ADIcon,
                size: CGFloat = 22,
                foregroundColor: Color = .black,
                action: @escaping () -> Void) {
        self.icon = icon
        self.symbolName = ""
        self.symbolVariant = .none
        self.size = size
        self.foregroundColor = foregroundColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            iconView()
                .resizable()
                .scaledToFit()
                .symbolVariant(symbolVariant)
                .frame(width: size, height: size)
                .foregroundStyle(foregroundColor)
        }
    }
    
    private func iconView() -> Image {
        if symbolName.isEmpty {
            Image(icon)
        } else {
            Image(systemName: symbolName)
        }
    }
}

extension ADIconButton {
    public init(symbolName: String,
                symbolVariant: SymbolVariants = .none,
                size: CGFloat = 22,
                foregroundColor: Color = .black,
                action: @escaping () -> Void) {
        self.icon = .none
        self.symbolName = symbolName
        self.symbolVariant = .none
        self.size = size
        self.foregroundColor = foregroundColor
        self.action = action
    }
}
