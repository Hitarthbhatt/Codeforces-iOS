//
//  BaseButtonGlassStyle.swift
//  Platform
//
//  Created by Ankit Panchotiya on 24/10/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct BaseButtonGlassStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    private let buttonType: BaseButton.BaseButtonState
    private let isLoading: Bool
    private let isGlassEffect: Bool

    init(
        _ buttonType: BaseButton.BaseButtonState,
        _ isLoading: Bool,
        _ isGlassEffect: Bool
    ) {
        self.buttonType = buttonType
        self.isLoading = isLoading
        self.isGlassEffect = isGlassEffect
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .tint(isEnabled ? buttonType.foregroundColor : buttonType.disabledTextColor)
            .foregroundColor(isEnabled ? buttonType.foregroundColor : buttonType.disabledTextColor)
            .padding(.horizontal, buttonType.horizontalPadding)
            .padding(.vertical, buttonType.verticalPadding)
            .cornerRadius(buttonType.cornerRadius)
            .multilineTextAlignment(buttonType.textAlignment)
            .if(!isGlassEffect, transform: { view in
                view
                    .background(isEnabled || self.isLoading ? buttonType.backgroundColor : buttonType.disabledColor)
            })
            .if(buttonType.isButtonRectangle, transform: { view in
                view
                    .overlay(
                        RoundedRectangle(cornerRadius: buttonType.cornerRadius)
                            .stroke(buttonType.borderColor, lineWidth: 1)
                            .opacity(isEnabled ? (configuration.isPressed ? 0.7 : 1) : 0.5)
                    )
            })
            .if(buttonType.isButtonCircle, transform: { view in
                view
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(buttonType.borderColor, lineWidth: 1)
                    )
            })
            .if(isGlassEffect, transform: { view in
                view
                    .buttonStyle(.glass)
            })
    }
}
