//
//  PersistentStorageKeys.swift
//  Platform
//
//  Created by Ankit Panchotiya on 29/10/25.
//

import Foundation

public enum PersistentStorageKeys: String {
    case token
    case refreshToken
    case userInfo

    var keyName: String {
        switch self {
        case .token:
            return "token"
        case .refreshToken:
            return "refresh_token"
        case .userInfo:
            return "user_info"
        }
    }
}
