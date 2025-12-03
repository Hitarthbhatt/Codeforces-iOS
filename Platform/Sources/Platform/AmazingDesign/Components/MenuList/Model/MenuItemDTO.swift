//
//  MenuItemDTO.swift
//  Platform
//
//  Created by Ankit Panchotiya on 10/02/25.
//

import Foundation

extension ADMenuListView {
    
    public struct MenuItemDTO: Identifiable {
        public let id = UUID()
        public let title: String
        public let action: () -> Void
        
        
        public init(title: String, action: @escaping () -> Void) {
            self.title = title
            self.action = action
        }
    }
}
