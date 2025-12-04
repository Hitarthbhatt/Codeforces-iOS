//
//  TabBar.swift
//  PairPenguin
//
//  Created by Ankit Panchotiya on 12/10/25.
//

import Foundation
import SwiftUI
import Platform

public enum CustomTabBarItem: TabBarItemProtocol {
    case problem
    case profile
    
    public var tag: Int {
        return switch self {
        case .problem:
            0
        case .profile:
            1
        }
    }
    
    public var imageName: String {
        return switch self {
        case .problem: "house"
        case .profile: "person.crop.circle"
        }
    }
    
    public var text: String {
        switch self {
        case .problem:
            return "Problems"
        case .profile:
            return "Profile"
        }
    }
    
    public var selectedColor: Color { .brandPrimaryBG }
    public var unSelectedColor: Color { .primaryLabel }
    
    @MainActor
    public func getContent() -> some View {
        switch self {
        case .problem:
            NavigationTab {
                ProblemListView()
            }
        case .profile:
            Text("Profile")
        }
    }
}
