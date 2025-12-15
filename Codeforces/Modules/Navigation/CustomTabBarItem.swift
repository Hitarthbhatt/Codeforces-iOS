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
    case contest
    case profile
    
    public var tag: Int {
        return switch self {
        case .problem: 0
        case .contest: 1
        case .profile: 2
        }
    }
    
    public var imageName: String {
        return switch self {
        case .problem: "house"
        case .contest: "trophy"
        case .profile: "person.crop.circle"
        }
    }
    
    public var text: String {
        switch self {
        case .problem:
            return "Problems"
        case .contest:
            return "Contests"
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
        case .contest:
            Text("Contest")
        case .profile:
            NavigationTab {
                ProfileMainView()
            }
        }
    }
}
