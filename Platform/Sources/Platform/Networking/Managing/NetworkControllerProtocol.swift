//
//  NetworkControllerProtocol.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation
import Combine

public protocol NetworkControllerProtocol {
    
    func makeWebSocketTask(requestItem: RequestItems) throws -> URLSessionWebSocketTask
    func apiCall<T: Decodable>(requestItem: RequestItems,
                               triesLeft: Int?,
                               params: [String: Any]?,
                               type: T.Type) -> AnyPublisher<T, Error>
}

public extension NetworkControllerProtocol {

    func apiCall<T: Decodable>(requestItem: RequestItems,
                               triesLeft: Int? = 2,
                               params: [String: Any]?,
                               type: T.Type) -> AnyPublisher<T, Error> {
        return apiCall(requestItem: requestItem, triesLeft: triesLeft, params: params, type: type)
    }
}
