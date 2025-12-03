//
//  RoundedBackgroundViewModifier.swift
//  Environment
//
//  Created by Ankit Panchotiya on 18/01/25.
//
import SwiftUI

struct RoundedBackgroundViewModifier: ViewModifier {
    let verticalPadding: CGFloat
    let horizontalPadding: CGFloat
    let bgColor: Color
    let borderColor: Color
    let borderWidth: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .if(horizontalPadding <= 0, transform: { view in
                view.infiniteWidth()
            })
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

public extension View {
    func roundedBackground(
        vertical: CGFloat,
        horizontal: CGFloat,
        bgColor: Color,
        borderColor: Color = Color.solidBorder,
        borderWidth: CGFloat = 1,
        cornerRadius: CGFloat
    ) -> some View {
        modifier(
            RoundedBackgroundViewModifier(
                verticalPadding: vertical,
                horizontalPadding: horizontal,
                bgColor: bgColor,
                borderColor: borderColor,
                borderWidth: borderWidth,
                cornerRadius: cornerRadius
            )
        )
    }
}
