import SwiftUI

public struct ChatTextField<T: Hashable>: View {
    @State private var msgText: String = ""
    private var sendIcon: ADIcon
    private var action: (String) -> Void
    var field: T
    @FocusState var focusedField: T?

    public init(
        field: T,
        focusedField: FocusState<T?> = .init(),
        sendIcon: ADIcon = .focusChat,
        action: @escaping (String) -> Void
    ) {
        self.field = field
        self._focusedField = focusedField
        self.sendIcon = sendIcon
        self.action = action
    }

    public var body: some View {
        HStack(spacing: 9) {
            textFieldView()
        } // HStack
        .infiniteWidth()
    }

    @ViewBuilder
    private func textFieldView() -> some View {

        HStack(spacing: 12) {
            TextField("Enter Text...", text: $msgText, axis: .vertical)
                .font(.appFont(.body, .regular))
                .foregroundStyle(Color.secondaryLabel)
                .focused($focusedField, equals: field)
                .frame(maxHeight: 54)
                .fixedSize(horizontal: false, vertical: true)
                .roundedBackground(
                    vertical: 16,
                    horizontal: 16,
                    bgColor: Color.secondaryBG,
                    borderColor: .clear,
                    borderWidth: 0,
                    cornerRadius: 28
                )

            BaseButton(
                icon: sendIcon.rawValue,
                buttonType: BaseButton.circleIcon(),
                action: {
                    let tempMsg = msgText
                    action(tempMsg)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        msgText = ""
                    }
                }
            )
        }
    }
}

#Preview {
    VStack {
        ChatTextField(
            field: 0,
            action: { message in

            }
        )
    }
    .background(Color.primaryBG)
}

