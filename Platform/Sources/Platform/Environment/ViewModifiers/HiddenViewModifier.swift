//
//  SwiftUIView.swift
//  Environment
//
//  Created by Ankit Panchotiya on 02/12/24.
//

import SwiftUI

public struct HiddenViewModifier: ViewModifier {
    var isHidden: Bool
    
    public init(isHidden: Bool) {
        self.isHidden = isHidden
    }
    
    public func body(content: Content) -> some View {
        if !isHidden {
            content
        }
    }
}

public extension View {
    func hidden(_ isHidden: Bool) -> some View {
        modifier(HiddenViewModifier(isHidden: isHidden))
    }
}
