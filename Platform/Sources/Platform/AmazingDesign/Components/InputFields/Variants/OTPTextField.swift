//
//  SwiftUIView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 03/02/25.
//

import SwiftUI
import Combine

public struct OTPFieldView: View {
    @FocusState private var pinFocusState: Int?
    @Binding private var otp: String
    @State private var pins: [String]
    @State private var textFiledState: [TextFieldState] = []
    
    var numberOfFields: Int
    
    public init(numberOfFields: Int, otp: Binding<String>) {
        self.numberOfFields = numberOfFields
        self._otp = otp
        self._pins = State(initialValue: Array(repeating: "", count: numberOfFields))
        self._textFiledState = State(
            initialValue: Array(repeating: .inActive, count: numberOfFields)
        )
    }
    
    public var body: some View {
        HStack(spacing: 14) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("", text: $pins[index])
                    .textFieldStyle(
                        BaseTextFieldStyle(
                            model: .otp,
                            text: $pins[index],
                            textFieldActiveState: $textFiledState[index],
                            field: index,
                            focusedField: _pinFocusState,
                            previousField: index - 1 >= 0 ? index - 1 : nil,
                            nextField: index + 1 < numberOfFields ? index + 1 : nil
                        )
                    )
                    .submitLabel(index == numberOfFields - 1 ? .done : .next)
                    .onChange(of: pins[index]) { oldVal, newVal in
                        if newVal.count == numberOfFields, let _ = Int(newVal) {
                            otp = newVal
                            updatePinsFromOTP()
                        }
                        updateOTPString()
                    }
            }
        }
        .onAppear {
            updatePinsFromOTP()
        }
    }
    
    private func updatePinsFromOTP() {
        let otpArray = Array(otp.prefix(numberOfFields))
        for (index, char) in otpArray.enumerated() {
            pins[index] = String(char)
        }
    }
    
    private func updateOTPString() {
        otp = pins.joined()
    }
}
