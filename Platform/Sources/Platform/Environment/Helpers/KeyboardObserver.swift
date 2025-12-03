//
//  KeyboardObserver.swift
//  Platform
//
//  Created by Ankit Panchotiya on 25/10/25.
//

import SwiftUI
import Combine

final public class KeyboardObserver: ObservableObject {
    @Published public var isKeyboardVisible: Bool = false

    private var cancellables = Set<AnyCancellable>()

    public init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
            .merge(with:
                    NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
            )
            .receive(on: RunLoop.main)
            .assign(to: \.isKeyboardVisible, on: self)
            .store(in: &cancellables)
    }
}
