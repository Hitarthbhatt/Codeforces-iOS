//
//  Font+Extension.swift
//  Redbuk
//
//  Created by Ankit Panchotiya on 04/08/24.
//

import SwiftUI

public extension Font {
    static func sfProBlack(size: CGFloat) -> Font {
        .system(size: size, weight: .black)
    }

    static func sfProHeavy(size: CGFloat) -> Font {
        .system(size: size, weight: .heavy)
    }

    static func sfProBold(size: CGFloat) -> Font {
        .system(size: size, weight: .bold)
    }

    static func sfProUltraLight(size: CGFloat) -> Font {
        .system(size: size, weight: .ultraLight)
    }

    static func sfProLight(size: CGFloat) -> Font {
        .system(size: size, weight: .light)
    }

    static func sfProMedium(size: CGFloat) -> Font {
        .system(size: size, weight: .medium)
    }

    static func sfProRegular(size: CGFloat) -> Font {
        .system(size: size, weight: .regular)
    }

    static func sfProSemiBold(size: CGFloat) -> Font {
        .system(size: size, weight: .semibold)
    }

    static func sfProThin(size: CGFloat) -> Font {
        .system(size: size, weight: .thin)
    }
}
