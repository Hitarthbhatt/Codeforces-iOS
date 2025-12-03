//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 12/10/25.
//

import Foundation

final public class Util {
    public static var isIOS26: Bool {
        if #available(iOS 26.0, *) {
            return true
        }
        return false
    }
}
