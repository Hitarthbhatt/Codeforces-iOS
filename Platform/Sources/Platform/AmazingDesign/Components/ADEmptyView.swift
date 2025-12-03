//
//  ADEmptyView.swift

import SwiftUI

public struct ADEmptyView: View {
    public struct Model {
        public let text: String
        public let description: String
        public let image: String
        public let buttonText: String
        public let buttonAction: () -> Void
        
        public init(text: String, description: String, image: String, buttonText: String, buttonAction: @escaping () -> Void) {
            self.text = text
            self.description = description
            self.image = image
            self.buttonText = buttonText
            self.buttonAction = buttonAction
        }
    }
    
    let model: Model
    
    public init (model: Model) {
        self.model = model
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(model.image)
                .resizable()
                .squareFrame(size: 100)
                .padding(.bottom, 30)
            
            Text(model.text)
                .font(.appFont(.callout, .semibold))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)
            
            Text(model.description)
                .font(.appFont(.footnote, .medium))
                .foregroundStyle(Color.inverseLabel)
                .multilineTextAlignment(.center)
                .padding(.bottom, 15)
            
            BaseButton(
                title: model.buttonText,
                isLoading: false,
                buttonType: BaseButton.primaryButton
            ) {
                model.buttonAction()
            }
            .padding(.horizontal, 30)
        } // VStack
    }
}

#Preview {
    ADEmptyView(
        model: .init(
            text: "Track Your Spendings",
            description: "No transactions recorded. Let’s change that!",
            image: "",
            buttonText: "Add New Transaction",
            buttonAction: {}
        )
    )
}
