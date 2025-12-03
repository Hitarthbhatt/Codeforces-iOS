//
//  ADTextStyle.swift
//  Platform
//
//  Created by Ankit Panchotiya on 14/10/25.
//

import Foundation
import SwiftUI

public enum ADTextStyle {
    case largeTitle, title1, title2, title3
    case headline, body, callout, subHeadline
    case footnote, caption1, caption2
    
    var style: Font.TextStyle {
        switch self {
        case .largeTitle: .largeTitle
        case .title1: .title
        case .title2: .title2
        case .title3: .title3
        case .headline: .headline
        case .body: .body
        case .callout: .callout
        case .subHeadline: .subheadline
        case .footnote: .footnote
        case .caption1: .caption
        case .caption2: .caption2
        }
    }
}

public extension Font {
    
    static func appFont(_ style: ADTextStyle, _ weight: Font.Weight = .regular) -> Font {
        .system(style.style, design: .default, weight: weight)
    }
}
