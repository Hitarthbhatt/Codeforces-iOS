//
//  AppViewModel.swift
//  PairPenguin
//
//  Created by Ankit Panchotiya on 13/10/25.
//

import Combine
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedTabItem: CustomTabBarItem

    init(selectedTabItem: CustomTabBarItem = .problem) {
        self.selectedTabItem = selectedTabItem
    }
}
