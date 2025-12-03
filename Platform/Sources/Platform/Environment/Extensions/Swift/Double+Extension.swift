//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 20/02/25.
//

import Foundation

public extension Double {
    /// Rounds the number up to the specified number of decimal places.
    func roundedUp(_ places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return ceil(self * multiplier) / multiplier
    }
}
