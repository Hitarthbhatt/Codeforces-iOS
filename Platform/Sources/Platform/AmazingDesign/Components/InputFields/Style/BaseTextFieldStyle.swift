//
//  BaseTextFieldStyle.swift
//

import SwiftUI
import Combine

public struct BaseTextFieldStyle<T: Hashable>: TextFieldStyle {
    var model: Model
    @Binding var text: String
    @Binding var textFieldActiveState: TextFieldState
    var field: T
    @FocusState var focusedField: T?
    var previousField: T?
    var nextField: T?
    
    public init(
        model: Model,
        text: Binding<String> = .constant(""),
        textFieldActiveState: Binding<TextFieldState>,
        field: T,
        focusedField: FocusState<T?> = .init(),
        previousField: T? = nil,
        nextField: T? = nil
    ) {
        self.model = model
        self._text = text
        self._textFieldActiveState = textFieldActiveState
        self.field = field
        self._focusedField = focusedField
        self.previousField = previousField
        self.nextField = nextField
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: model.spacingBetweenViews) {
            if model.headerText.isNotEmpty {
                Text(LocalizedStringKey(model.headerText))
                    .font(model.headerTextFont)
                    .foregroundStyle(model.headerTextColor)
                    .padding(.leading, model.insideHorizontalPadding)
            }
            
            HStack(spacing: model.spaceBetweenIcon) {
                iconView()
                    .hidden(model.iconPosition == .trailing)
                
                configuration
                    .font(model.textFont)
                    .foregroundStyle(model.textColor)
                    .multilineTextAlignment(model.textAlignment)
                    .keyboardType(model.keyboardType)
                    .textContentType(.emailAddress)
                    .focused($focusedField, equals: field)
                    .onSubmit { focusedField = nextField }
                
                iconView()
                    .hidden(model.iconPosition == .leading)
            } // HStack
            .padding(.horizontal, model.insideHorizontalPadding)
            .padding(.vertical, model.verticalPadding)
            .padding(.horizontal, model.horizontalPadding)
            .frame(minWidth: model.minTextFieldWidth)
            .if(model.horizontalPadding <= 0, transform: { view in
                view.infiniteWidth()
            })
            .background(model.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: model.cornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: model.cornerRadius)
                    .stroke(getBorderColor, lineWidth: model.borderWidth)
            }
            .onChange(of: focusedField) { oldValue, newValue in
                textFieldActiveState = focusedField == field ? .active : .inActive
            }
            .onReceive(Just(text), perform: { _ in limitText(model.textLimit) })
            .onChange(of: text) { _, newValue in
                if model.autoNext && newValue.count == model.textLimit {
                    focusedField = nextField
                } else if model.autoPrevious && newValue.isEmpty {
                    focusedField = previousField
                }
            }
            
            if statusText.isNotEmpty {
                Text(statusText)
                    .font(model.statusTextFont)
                    .foregroundStyle(getBorderColor)
                    .padding(.leading, 14)
            }
        } // VStack
    }
    
    private var getBorderColor: Color {
        return switch textFieldActiveState {
        case .active:
            Color.primaryBorder
        case .inActive, .disable:
            Color.clear
        case .success:
            Color.successColor
        case .error:
            Color.errorColor
        }
    }
    
    private var statusText: String {
        switch textFieldActiveState {
        case .success(let value):
            return value
        case .error(let value):
            return value
        default:
            return ""
        }
    }
    
    @ViewBuilder
    private func iconView() -> some View {
        Image(model.iconName)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(model.iconColor)
            .squareFrame(size: model.iconSize)
            .hidden(model.iconName.isEmpty)
    }
    
    private func limitText(_ textLimit: Int) {
        if textLimit > 0 && text.count > textLimit {
            self.text = String(text.prefix(textLimit))
        }
    }
}
