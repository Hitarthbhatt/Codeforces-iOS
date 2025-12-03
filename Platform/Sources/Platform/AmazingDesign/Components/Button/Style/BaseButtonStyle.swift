//
//  BaseButtonStyle.swift


import SwiftUI

struct BaseButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    private let buttonType: BaseButton.BaseButtonState
    private let isLoading: Bool

    init(_ buttonType: BaseButton.BaseButtonState, isLoading: Bool) {
        self.buttonType = buttonType
        self.isLoading = isLoading
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .tint(isEnabled ? buttonType.foregroundColor : buttonType.disabledTextColor)
            .foregroundColor(isEnabled || self.isLoading ? buttonType.foregroundColor : buttonType.disabledTextColor)
            .padding(.horizontal, buttonType.horizontalPadding)
            .padding(.vertical, buttonType.verticalPadding)
            .background(isEnabled || self.isLoading ? buttonType.backgroundColor : buttonType.disabledColor)
            .cornerRadius(buttonType.cornerRadius)
            .multilineTextAlignment(buttonType.textAlignment)
            .if(buttonType.isButtonRectangle, transform: { view in
                view
                    .overlay(
                        RoundedRectangle(cornerRadius: buttonType.cornerRadius)
                            .stroke(buttonType.borderColor, lineWidth: buttonType.borderWidth)
                            .opacity(isEnabled ? (configuration.isPressed ? 0.7 : 1) : 0.5)
                    )
            })
            .if(buttonType.isButtonCircle, transform: { view in
                view
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(buttonType.borderColor, lineWidth: buttonType.borderWidth)
                    )
            })
    }
}
