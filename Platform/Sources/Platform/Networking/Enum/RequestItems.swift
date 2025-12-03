//
//  RequestItems.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation

public enum RequestItems {
    case login
    case getSoloChatList
    case getChatMessages(chatId: UUID)
}

extension RequestItems: EndPoints {

    // MARK: - Private computed properties
    private var baseURL: String {
        switch self {
        default:
            return AppConstant.serverURL
        }
    }

    private var version: String {
        switch self {
        default:
            return "v1"
        }
    }

    private var path: String {
        switch self {
        case .login:
            return "user/sign-in"
        case .getSoloChatList:
            return "/solo_chats"
        case .getChatMessages(let chatId):
            return "/solo_chats/\(chatId)"
        }
    }

    private var urlStr: String {
        switch self {
        default:
            return baseURL + version + path
        }
    }

    // MARK: - Internal computed properties
    var url: URL? {
        guard let urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStr) else { return nil }
        return url
    }

    var responseInJson: Bool {
        switch self {
        default:
            return true
        }
    }

    var isCookieAllow: Bool {
        switch self {
        default:
            return true
        }
    }

    var httpMethod: HTTPMethod {
        return switch self {
        case .getChatMessages:
                .GET
        default:
                .POST
        }
    }

    var header: [String: String]? {
        let accessToken = KeychainManager.shared.readToken(for: .token) ?? ""
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        default:
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }
}
