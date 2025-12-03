//
//  BaseButtonState+Authentication.swift

import CoreFoundation
import SwiftUI

// MARK: - Authentication
extension BaseButton {
    
    static public let primaryButton = BaseButtonState(
        font: .appFont(.headline, .medium),
        foregroundColor: .white,
        backgroundColor: .brandPrimaryBG,
        disabledTextColor: .gray,
        disabledColor: .gray,
    )
    
    static public let primaryFilledButton = BaseButtonState(
        font: .appFont(.footnote, .semibold),
        foregroundColor: .white,
        backgroundColor: .brandPrimaryBG,
        disabledTextColor: .white.opacity(0.3),
        disabledColor: .brandPrimaryBG.opacity(0.3),
        cornerRadius: 8,
        verticalPadding: 8,
        horizontalPadding: 10,
    )
    
    static public let secondaryTransparentButton = BaseButtonState(
        font: .appFont(.caption1, .regular),
        foregroundColor: .secondaryLabel,
        textAlignment: .leading,
        backgroundColor: .clear,
        verticalPadding: 1,
        horizontalPadding: 1,
    )
    
    static public let rectangleActionButton = BaseButtonState(
        font: .appFont(.footnote, .semibold),
        foregroundColor: Color.primaryIcon,
        iconColor: Color.primaryIcon,
        backgroundColor: Color.primaryBG,
        borderColor: Color.primaryBorder,
        borderWidth: 1,
        cornerRadius: 8,
        verticalPadding: 10,
        horizontalPadding: 10,
        isButtonRectangle: true
    )

    static public let secondaryButton = BaseButtonState(
        font: .appFont(.headline, .medium),
        foregroundColor: .primaryLabel,
        backgroundColor: .primaryBG,
        borderColor: .primaryBorder,
        borderWidth: 1
    )

    static public let glassEffect = BaseButtonState(
        font: .appFont(.headline, .medium),
        foregroundColor: .white,
        backgroundColor: .clear,
        disabledTextColor: .gray,
        disabledColor: .gray,
        verticalPadding: 10,
        horizontalPadding: 10,
        isButtonRectangle: false,
        isButtonCircle: true,
        isGlassEffect: true
    )

    static public let circleGlassEffect = BaseButtonState(
        font: .appFont(.headline, .medium),
        foregroundColor: .white,
        backgroundColor: .clear,
        disabledTextColor: .gray,
        disabledColor: .gray,
        verticalPadding: 0.01,
        horizontalPadding: 0.01,
        isButtonRectangle: false,
        isButtonCircle: true,
        isGlassEffect: true
    )

    static public func circleIcon(
        background: Color = .brandPrimaryBG,
        spacing: CGFloat = 16
    ) -> BaseButtonState {
        return BaseButtonState(
            font: .appFont(.headline, .regular),
            foregroundColor: .white,
            backgroundColor: background,
            borderWidth: 0,
            verticalPadding: spacing,
            horizontalPadding: spacing,
            isButtonRectangle: false,
            isButtonCircle: true
        )
    }

    static public func navIconWithOutGlass(
        background: Color = .brandPrimaryBG
    ) -> BaseButtonState {
        return BaseButtonState(
            font: .appFont(.headline, .regular),
            foregroundColor: .white,
            backgroundColor: background,
            disabledTextColor: .clear,
            disabledColor: .clear,
            borderWidth: 0,
            verticalPadding: 5,
            horizontalPadding: 5,
            isButtonRectangle: false,
            isButtonCircle: true
        )
    }
}
