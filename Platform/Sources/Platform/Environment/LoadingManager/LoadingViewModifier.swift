//
//  SwiftUIView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 20/02/25.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    @Environment(LoadingManager.self) var loadingManager
    let id: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(loadingManager.isLoading(id: id))
                .blur(radius: loadingManager.isLoading(id: id) ? 3 : 0)
            
            if loadingManager.isLoading(id: id) {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding()
                    Text("Loading...")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                .frame(width: 150, height: 150)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }
}

public extension View {
    func loadingView(id: String) -> some View {
        self.modifier(LoadingModifier(id: id))
    }
}
