//
//  UINavigationBar+Extension.swift
//  Platform
//
//  Created by Ankit Panchotiya on 06/04/25.
//
import UIKit
import SwiftUI

extension UINavigationBar {
    
    static public func setCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.primaryBG)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
