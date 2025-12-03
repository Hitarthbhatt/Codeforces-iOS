import SwiftUI

public extension Text {
    func sfProBlack(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .black))
    }
    
    func sfProHeavy(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .heavy))
    }
    
    func sfProBold(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .bold))
    }
    
    func sfProUltraLight(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .ultraLight))
    }
    
    func sfProLight(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .light))
    }
    
    func sfProMedium(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .medium))
    }
    
    func sfProRegular(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .regular))
    }
    
    func sfProSemiBold(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .semibold))
    }
    
    func sfProThin(size: CGFloat) -> Self {
        self.font(.system(size: size, weight: .thin))
    }
}

/// Modifier for dynamic attributed stings.
public extension Text {
    init(_ content: String, attributes: (inout AttributedString) -> Void) {
        var attributedString = AttributedString(content)
        attributes(&attributedString)
        self.init(attributedString)
    }
}
