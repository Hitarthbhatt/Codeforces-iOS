import SwiftUI

public extension Image {
    func resizableImage(
        width: CGFloat = .infinity,
        height: CGFloat = .infinity,
        contentMode: ContentMode = .fit
    ) -> some View {
        self.resizable()
            .if(contentMode == .fit, transform: { image in
                image.scaledToFit()
            })
            .if(contentMode == .fill, transform: { image in
                image.scaledToFill()
            })
            .frame(maxWidth: width, maxHeight: height)
    }
    
    func resizableImage(size: CGFloat, contentMode: ContentMode = .fit) -> some View {
        self.resizable()
            .if(contentMode == .fit, transform: { image in
                image.scaledToFit()
            })
            .if(contentMode == .fill, transform: { image in
                image.scaledToFill()
            })
            .squareFrame(size: size)
    }
}

// MARK: - Initialiser.
public extension Image {
    init(_ icon: ADIcon) {
        self.init(icon.rawValue, bundle: .main)
    }
}
