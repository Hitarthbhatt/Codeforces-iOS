//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 03/02/25.
//

import SwiftUI

public struct PrimaryTextField<T: Hashable>: View {
    var model: BaseTextFieldStyle<T>.Model
    var placeholder: String
    @Binding var text: String
    @Binding var textFieldActiveState: TextFieldState
    var field: T
    @FocusState var focusedField: T?
    var previousField: T?
    var nextField: T?
    
    public init(
        model: BaseTextFieldStyle<T>.Model = .email,
        placeholder: String,
        text: Binding<String>,
        textFieldActiveState: Binding<TextFieldState>,
        field: T,
        focusedField: FocusState<T?> = .init(),
        previousField: T? = nil,
        nextField: T? = nil
    ) {
        self.model = model
        self.placeholder = placeholder
        self._text = text
        self._textFieldActiveState = textFieldActiveState
        self.field = field
        self._focusedField = focusedField
        self.nextField = nextField
    }
    
    public var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .font(model.placeholderTextFont)
                .foregroundStyle(model.placeholderTextColor)
        )
        .keyboardType(model.keyboardType)
        .autocapitalization(model.autoCapitalization)
        .textFieldStyle(
            BaseTextFieldStyle<T>(
                model: model,
                textFieldActiveState: $textFieldActiveState,
                field: field,
                focusedField: _focusedField,
                previousField: previousField,
                nextField: nextField
            )
        )
    }
}
