import SwiftUI

public extension View {
    func hideNavigationBar() -> some View {
        self.toolbarTitleDisplayMode(.inline)
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
    }
    
    func hideKeyboardOnTapIfVisible() -> some View {
        self.simultaneousGesture(
            TapGesture().onEnded {
                UIApplication.shared.dismissKeyboard()
            }
        )
    }
    
}

public extension View {
    func infiniteWidth(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func infiniteHeight(alignment: Alignment = .center) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func infiniteFrame(alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func squareFrame(size: CGFloat) -> some View {
        self.frame(width: size, height: size, alignment: .center)
    }
}

/// Conditional Modifiers
public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform `transform` or `else`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    ///   - else: The transform that applies if `condition` is false
    /// - Returns: Either the original `View` or the modified `View` based on the condition`.
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content, @ViewBuilder else: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            `else`(self)
        }
    }
    
    /// Unwraps the given `value` and applies the given `transform`.
    /// - Parameters:
    ///   - value: The value to unwrap.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` with unwrapped `value` if the `value` is not nil`.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, @ViewBuilder transform: (Value, Self) -> Content) -> some View {
        if let value = value {
            transform(value, self)
        } else {
            self
        }
    }
    
    /// Unwraps the given `value` and applies the given `transform`.
    /// - Parameters:
    ///   - value: The value to unwrap.
    ///   - transform: The transform to apply to the source `View`.
    ///   - else:The transform that applies if `value` is nil
    /// - Returns: Either the `else` transform or the modified `View` with unwrapped `value` if the `value` is not nil`.
    @ViewBuilder
    func ifLet<Value, Content: View>(_ value: Value?, @ViewBuilder transform: (Value, Self) -> Content, @ViewBuilder else: (Self) -> Content) -> some View {
        if let value = value {
            transform(value, self)
        } else {
            `else`(self)
        }
    }
}

// MARK: Glass Effect (iOS 26)
public extension View {
    @ViewBuilder
    func applyGlassEffect(shape: some Shape = RoundedRectangle(cornerRadius: 12)) -> some View {
        if #available(iOS 26.0, *) {
            self.glassEffect(.regular, in: shape)
        } else {
            self
        }
    }
}

// MARK: - Apply button style
extension View {
    
    @ViewBuilder
    func applyButtonStyle(
        for buttonType: BaseButton.BaseButtonState,
        isLoading: Bool
    ) -> some View {
        if #available(iOS 26.0, *) {
            if buttonType.isGlassEffect {
                self.buttonStyle(
                    BaseButtonGlassStyle(
                        buttonType,
                        isLoading,
                        buttonType.isGlassEffect
                    )
                )
            } else {
                self.buttonStyle(BaseButtonStyle(buttonType, isLoading: isLoading))
            }
        } else {
            self.buttonStyle(BaseButtonStyle(buttonType, isLoading: isLoading))
        }
    }
}

