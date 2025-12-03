//
//  ADErrorView.swift

import SwiftUI

public struct ADErrorView: View {
    public struct Model {
        var image: String
        var title: String
        var message: String
        var titleFont: Font
        var titleColor: Color
        var messageFont: Font
        var messageColor: Color
        
        public init(
            image: String,
            title: String,
            message: String,
            titleFont: Font = .sfProBold(size: 32),
            titleColor: Color = .white,
            messageFont: Font = .sfProMedium(size: 20),
            messageColor: Color = .errorDisabledLabel
        ) {
            self.image = image
            self.title = title
            self.message = message
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.messageFont = messageFont
            self.messageColor = messageColor
        }
    }
    
    var model: Model
    
    public init(model: Model) {
        self.model = model
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            Text(model.title)
                .font(model.titleFont)
                .foregroundStyle(model.titleColor)
                .padding(.top, 25)
            
            Text(model.message)
                .font(model.messageFont)
                .foregroundStyle(model.messageColor)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        } // VStack
    }
}
