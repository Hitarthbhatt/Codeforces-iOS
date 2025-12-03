//
//  SwiftUIView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 14/10/25.
//

import SwiftUI

public struct TagCapsuleView: View {

    private var title: String
    private var textColor: Color
    private var bgColor: Color

    public init(
        title: String,
        textColor: Color = .primaryLabel,
        bgColor: Color = Color.tertiaryBG
    ) {
        self.title = title
        self.textColor = textColor
        self.bgColor = bgColor
    }

    public var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.appFont(.caption1, .semibold))
                .foregroundStyle(textColor)
        }
        .roundedBackground(
            vertical: .vSpacingMedium,
            horizontal: .hSpacingRegular,
            bgColor: bgColor,
            borderColor: .clear,
            borderWidth: 0,
            cornerRadius: 32
        )
        .padding(0.5)
    }
}

#Preview {

    TagCapsuleView(
        title: "Achievement",
        bgColor: Color.primaryLabel
    )
}
