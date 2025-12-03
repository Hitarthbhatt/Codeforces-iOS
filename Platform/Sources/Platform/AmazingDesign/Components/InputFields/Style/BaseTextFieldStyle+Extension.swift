//
//  BaseTextFieldStyle.swift
//

import SwiftUI

public extension BaseTextFieldStyle {
    enum IconPosition {
        case leading
        case trailing
    }
    
    struct Model: Equatable {
        var headerText: String
        var headerTextColor: Color = .tertiaryLabel
        var headerTextFont: Font = .sfProSemiBold(size: 13)
        var textColor: Color = .white
        var textFont: Font = .sfProRegular(size: 17)
        var placeholderTextColor: Color = .gray
        var placeholderTextFont: Font = .sfProRegular(size: 17)
        var statusTextFont: Font = .sfProSemiBold(size: 13)
        var backgroundColor: Color = .brandPrimaryBG
        var cornerRadius: CGFloat = 12
        var borderWidth: CGFloat = 2
        var insideHorizontalPadding: CGFloat = 14
        var minTextFieldWidth: CGFloat = 0
        var horizontalPadding: CGFloat = 0
        var verticalPadding: CGFloat = 14
        var spacingBetweenViews: CGFloat = 6
        var keyboardType: UIKeyboardType = .default
        var textContentType: UITextContentType? = nil
        var autoCapitalization: UITextAutocapitalizationType = .sentences
        var textLimit: Int = 0
        var autoPrevious: Bool = false
        var autoNext: Bool = false
        var iconName: String = ""
        var iconSize: CGFloat = 20
        var iconPosition: IconPosition = .leading
        var iconColor: Color = .primaryIcon
        var spaceBetweenIcon: CGFloat = 14
        var textAlignment: TextAlignment = .leading
    }
}

public extension BaseTextFieldStyle.Model {
    static var email: Self {
        .init(
            headerText: "email_address",
            keyboardType: .emailAddress,
            textContentType: .emailAddress,
            autoCapitalization: .none
        )
    }
    
    static var otp: Self {
        .init(
            headerText: "",
            textFont: .sfProSemiBold(size: 20),
            insideHorizontalPadding: 9,
            minTextFieldWidth: 30,
            verticalPadding: 9,
            keyboardType: .numberPad,
            textContentType: .oneTimeCode,
            textLimit: 1,
            autoPrevious: true,
            autoNext: true,
            textAlignment: .center
        )
    }
    
    static var journalTitle: Self {
        .init(
            headerText: "",
            textColor: .primaryLabel,
            textFont: .appFont(.title3, .medium),
            placeholderTextColor: .secondaryLabel,
            placeholderTextFont: .appFont(.title3, .medium),
            backgroundColor: .clear,
            borderWidth: 0,
            insideHorizontalPadding: 0,
            horizontalPadding: 0,
            verticalPadding: 8,
        )
    }
    
    static var locationSearch: Self {
        .init(
            headerText: "",
            textColor: .tertiaryLabel,
            textFont: .appFont(.headline, .medium),
            placeholderTextColor: .tertiaryLabel,
            placeholderTextFont: .appFont(.headline, .medium),
            backgroundColor: .tertiaryBG,
            cornerRadius: 7,
            borderWidth: 0,
            insideHorizontalPadding: 0,
            horizontalPadding: 10,
            verticalPadding: 8,
            iconName: ADIcon.search.rawValue,
            iconSize: 15,
            iconColor: .tertiaryIcon
        )
    }
}
