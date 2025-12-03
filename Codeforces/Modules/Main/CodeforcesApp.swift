//
//  CodeforcesApp.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 03/12/25.
//

import SwiftUI
import Platform

@main
struct CodeforcesApp: App {
    private let userPreferences: UserPreferencesManaging = UserPreferences.shared
    @StateObject private var appViewModel: AppViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.userPreferences, userPreferences)
                .environmentObject(appViewModel)
        }
    }
}
