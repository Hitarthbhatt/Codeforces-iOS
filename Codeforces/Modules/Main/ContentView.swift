//
//  ContentView.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 03/12/25.
//

import SwiftUI
import Platform

struct ContentView: View {
    @Environment(\.userPreferences) private var userPreferences
    @EnvironmentObject private var appViewModel: AppViewModel
    
    var body: some View {
        NavigationTab {
            MainTabView(
                selectedTab: $appViewModel.selectedTabItem,
                allCases: CustomTabBarItem.allCases
            )
        }
    }
}

#Preview {
    ContentView()
}
