//
//  Size+Extension.swift
//  Platform
//
//  Created by Ankit Panchotiya on 26/10/25.
//
import Foundation
import SwiftUI
import UIKit

@MainActor
public struct Size {

    static public var screenWidth: CGFloat = UIScreen.main.bounds.width
    static public var screenHeight: CGFloat = UIScreen.main.bounds.height

    static public var getScreenHeight: CFloat {
        return CFloat(UIScreen.main.bounds.height)
    }

    static public var getScreenWidth: CFloat {
        return CFloat(UIScreen.main.bounds.width)
    }
}
