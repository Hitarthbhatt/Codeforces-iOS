//
//  BaseButton.swift

import SwiftUI

public struct BaseButton: View {
    let title: String?

    var icon: String
    var symbolName: String
    var iconColor: Color?
    var iconPosition: IconPosition
    var iconHeightSize: CGFloat
    var iconWidthSize: CGFloat
    var isLoading: Bool
    let buttonType: BaseButtonState
    let action: () -> Void

    public init(
        title: String? = nil,
        icon: String = "",
        symbolName: String = "",
        iconColor: Color? = nil,
        iconPosition: IconPosition = .leading,
        iconHeightSize: CGFloat = 24.0,
        iconWidthSize: CGFloat = 24.0,
        isLoading: Bool = false,
        buttonType: BaseButtonState,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.symbolName = symbolName
        self.icon = icon
        self.iconColor = iconColor
        self.iconPosition = iconPosition
        self.iconHeightSize = iconHeightSize
        self.iconWidthSize = iconWidthSize
        self.isLoading = isLoading
        self.buttonType = buttonType
        self.action = action
    }

    public var body: some View {
        Button {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            action()
        } label: {
            HStack(alignment: .center, spacing: 2) {
                if shouldShowImage(), !isLoading {
                    iconView()
                        .hidden(iconPosition != .leading)
                }
                if let title = title, !isLoading {
                    Text(title)
                        .font(buttonType.font)
                        .multilineTextAlignment(buttonType.textAlignment)
                        .if(buttonType.isTextUnderline, transform: { view in
                            view
                                .underline(true, pattern: .solid, color: buttonType.foregroundColor)
                        })
                }

                if shouldShowImage(), !isLoading {
                    iconView()
                        .hidden(iconPosition != .trailing)
                }

                if isLoading {
                    ProgressView()
                        .foregroundStyle(Color.black)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                        .padding(.leading, 5)
                }
            }
            .if(buttonType.horizontalPadding <= 0, transform: { view in
                view.infiniteWidth()
            })
        }
        .disabled(isLoading)
        .applyButtonStyle(for: buttonType, isLoading: isLoading)
    }
}

// MARK: - Leading and trailing Image
extension BaseButton {
    private func shouldShowImage() -> Bool {
        !icon.isEmpty || !symbolName.isEmpty
    }

    private func iconView() -> some View {
        let image: () -> Image = {
            if icon.isNotEmpty {
                Image(icon)
            } else {
                Image(systemName: symbolName)
            }
        }

        return image()
            .resizable()
            .if(iconColor != nil, transform: { image in
                image.renderingMode(.template)
            })
            .scaledToFit()
            .if(iconColor != nil, transform: { image in
                image
                    .foregroundStyle(iconColor ?? Color.primaryIcon)
            })
            .frame(width: iconWidthSize, height: iconHeightSize, alignment: .center)
    }
}
