//
//  Environment.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 31/05/24.
//

import Foundation

/// AppConstant
public struct AppConstant {
    public static let environment = AppEnvironment()
    public static let serverURL = environment.configuration(PlistKey.serverURL) as? String ?? ""
}

/// PlistKey
public enum PlistKey {
    
    case serverURL
    
    public func value() -> String {
        switch self {
        case .serverURL:
            return "serverURL"
        }
    }
    
}

/// Environment
public struct AppEnvironment {
    /// fetch data from info.plist
    fileprivate var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    
    /// Provide value from info.plist file
    ///
    /// - Parameter key: Needed key
    /// - Returns: Get value in define datatype(Any you type cast later)
    func configuration(_ key: PlistKey) -> Any {
        switch key {
        case .serverURL:
            return infoDict[PlistKey.serverURL.value()] as? String ?? ""
        }
    }
}
