//
//  NetworkError.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError(String)
    case unknown
    case noInternetConnection
    case custom(String)
    case decodingFailed(String)
    case genericErrorMessage
    case authorizationError(String)
    case tokenMissing
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError(let error):
            return NSLocalizedString(error, comment: "Invalid response")
        case  .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .noInternetConnection:
            return NSLocalizedString("No internet Connection", comment: "No internet Connection")
        case .custom(let error):
            return NSLocalizedString(error, comment: "Unknown error")
        case .genericErrorMessage:
            return NSLocalizedString("Something went wrong, please try again.", comment: "Something went wrong, please try again.")
        case .authorizationError(let error):
            return NSLocalizedString(error, comment: "Authorisation revoke, Please Login again")
        case .tokenMissing:
            return NSLocalizedString("Token is missing.", comment: "Token is missing.")
        case .decodingFailed(let error):
            return NSLocalizedString(error, comment: "Decoding error: error")
        }
    }
}
