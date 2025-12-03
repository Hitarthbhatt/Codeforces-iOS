//
//  BaseButtonState.swift

import SwiftUI

extension BaseButton {
    
    public enum IconPosition {
        case leading
        case trailing
    }
    
    public struct BaseButtonState {
        let font: Font
        let foregroundColor: Color
        var textAlignment: TextAlignment
        var symbolName: String
        var icon: String
        var iconColor: Color
        var iconPosition: IconPosition
        var iconHeightSize: CGFloat
        var iconWidthSize: CGFloat
        var backgroundColor: Color
        var disabledTextColor: Color
        var disabledColor: Color
        var borderColor: Color
        var borderWidth: CGFloat
        var cornerRadius: CGFloat
        var verticalPadding: CGFloat
        var horizontalPadding: CGFloat
        var isGradientApply: Bool
        var isButtonRectangle: Bool
        var isButtonCircle: Bool
        var isTextUnderline: Bool = false
        var isGlassEffect: Bool = false

        init(
            font: Font,
            foregroundColor: Color,
            textAlignment: TextAlignment = .center,
            symbolName: String = "",
            icon: String = "",
            iconColor: Color = .white,
            iconPosition: IconPosition = .leading,
            iconHeightSize: CGFloat = 14.0,
            iconWidthSize: CGFloat = 14.0,
            backgroundColor: Color,
            disabledTextColor: Color = .black,
            disabledColor: Color = .gray,
            borderColor: Color = .clear,
            borderWidth: CGFloat = 0.0,
            cornerRadius: CGFloat = 13.0,
            verticalPadding: CGFloat = 13.0,
            horizontalPadding: CGFloat = 0.0,
            isGradientApply: Bool = false,
            isButtonRectangle: Bool = true,
            isButtonCircle: Bool = false,
            isTextUnderline: Bool = false,
            isGlassEffect: Bool = false
        ) {
            self.font = font
            self.foregroundColor = foregroundColor
            self.textAlignment = textAlignment
            self.symbolName = symbolName
            self.icon = icon
            self.iconColor = iconColor
            self.iconPosition = iconPosition
            self.iconHeightSize = iconHeightSize
            self.iconWidthSize = iconWidthSize
            self.backgroundColor = backgroundColor
            self.disabledTextColor = disabledTextColor
            self.disabledColor = disabledColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
            self.isGradientApply = isGradientApply
            self.isButtonRectangle = isButtonRectangle
            self.isButtonCircle = isButtonCircle
            self.isTextUnderline = isTextUnderline
            self.isGlassEffect = isGlassEffect
        }
    }
}
