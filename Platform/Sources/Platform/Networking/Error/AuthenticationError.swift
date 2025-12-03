//
//  AuthenticationError.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 29/05/24.
//

import Foundation

enum AuthenticationError: Error {
    case empptyPhonerNumber
    case validPhonerNumber
    case noVerificationID
    case sucessVerification
    case invalidState
    case unableToFetchToken
    case unableToSerializeToken
}

extension AuthenticationError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .empptyPhonerNumber:
            return "Please enter phone number."
        case .validPhonerNumber:
            return "Please enter a valid phone number."
        case .noVerificationID:
            return "No verification Id"
        case .sucessVerification:
            return "Code sent successfully. Please check your inbox or messages for the verification code."
        case .invalidState:
            return "Invalid state: A login callback was received, but no login request was sent."
        case .unableToFetchToken:
            return "Unable to fetch identity token"
        case .unableToSerializeToken:
            return "Unable to serialize token string from data"
        }
    }
}
