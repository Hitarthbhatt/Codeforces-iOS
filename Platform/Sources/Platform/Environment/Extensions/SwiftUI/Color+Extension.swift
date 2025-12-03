//
//  SwiftUIView.swift
//  Environment
//
//  Created by Ankit Panchotiya on 30/11/24.
//

import SwiftUI

extension Color {

    // MARK: - Backgrounds

    // Brand
    public static var brandDisabledBG: Color { Color("BrandDisabledBG") }
    public static var brandPrimaryBG: Color { Color("BrandPrimaryBG") }
    public static var brandSecondaryBG: Color { Color("BrandSecondaryBG") }
    public static var brandTertiaryBG: Color { Color("BrandTertiaryBG") }

    // Other
    public static var errorDisabledBG: Color { Color("ErrorDisabledBG") }
    public static var inverseBG: Color { Color("InverseBG") }

    // Theme
    public static var primaryBG: Color { Color("PrimaryBG") }
    public static var secondaryBG: Color { Color("SecondaryBG") }
    public static var tertiaryBG: Color { Color("TertiaryBG") }
    public static var quaternaryBG: Color { Color("QuaternaryBG") }

    public static var primary700: Color { Color("Primary700") }

    // MARK: - Borders

    // Other
    public static var dangerBorder: Color { Color("DangerBorder") }
    public static var disabledBorder: Color { Color("DisabledBorder") }
    public static var inverseBorder: Color { Color("InverseBorder") }
    public static var solidBorder: Color { Color("SolidBorder") }
    public static var successBorder: Color { Color("SuccessBorder") }
    public static var warningBorder: Color { Color("WarningBorder") }

    // Theme
    public static var primaryBorder: Color { Color("PrimaryBorder") }
    public static var secondaryBorder: Color { Color("SecondaryBorder") }
    public static var tertiaryBorder: Color { Color("TertiaryBorder") }


    // MARK: - Common Colors

    public static var errorColor: Color { Color("ErrorColor") }
    public static var successColor: Color { Color("SuccessColor") }


    // MARK: - Icons

    // Brand
    public static var brandDisabledIcon: Color { Color("BrandDisabledIcon") }
    public static var brandIcon: Color { Color("BrandIcon") }

    // Other
    public static var errorDisabledIcon: Color { Color("ErrorDisabledIcon") }
    public static var inverseIcon: Color { Color("InverseIcon") }

    // Theme
    public static var primaryIcon: Color { Color("PrimaryIcon") }
    public static var secondaryIcon: Color { Color("SecondaryIcon") }
    public static var tertiaryIcon: Color { Color("TertiaryIcon") }
    public static var quaternaryIcon: Color { Color("QuaternaryIcon") }


    // MARK: - Labels

    // Brand
    public static var brandDisabledLabel: Color { Color("BrandDisabledLabel") }
    public static var brandLabel: Color { Color("BrandLabel") }

    // Other
    public static var errorDisabledLabel: Color { Color("ErrorDisabledLabel") }
    public static var inverseLabel: Color { Color("InverseLabel") }
    public static var warningLabel: Color { Color("WarningLabel") }

    // Theme
    public static var primaryLabel: Color { Color("PrimaryLabel") }
    public static var secondaryLabel: Color { Color("SecondaryLabel") }
    public static var tertiaryLabel: Color { Color("TertiaryLabel") }
    public static var quaternaryLabel: Color { Color("QuaternaryLabel") }
    
    // MARK: - Supportive
    public static var supportiveGreen: Color { Color("SupportiveGreen") }
    public static var supportiveOrange: Color { Color("SupportiveOrange") }
    public static var supportiveRed: Color { Color("SupportiveRed") }
    public static var supportiveYellow: Color { Color("SupportiveYellow") }
}

public extension Color {
    func toHex(includeAlpha: Bool = false) -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        else { return nil }
        
        if includeAlpha {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                lroundf(Float(red * 255)),
                lroundf(Float(green * 255)),
                lroundf(Float(blue * 255)),
                lroundf(Float(alpha * 255))
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX",
                lroundf(Float(red * 255)),
                lroundf(Float(green * 255)),
                lroundf(Float(blue * 255))
            )
        }
    }
}
