//
//  NetworkManager.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation
import Combine

public final class NetworkManager {
    static public let shared: NetworkControllerProtocol = NetworkManager()
    private let logger: NetworkErrorLogger = DefaultNetworkErrorLogger(logger: LogFileLogger())
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = true
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        return URLSession(configuration: configuration)
    }()
}

extension NetworkManager: NetworkControllerProtocol {
    
    // MARK: - Internal methods
    public func apiCall<T: Decodable>(requestItem: RequestItems,
                                      triesLeft: Int?,
                                      params: [String: Any]?,
                                      type: T.Type) -> AnyPublisher<T, Error> {
        guard let urlRequest = getURLRequest(requestItem: requestItem, param: params) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        return data(urlRequest: urlRequest, triesLeft: triesLeft ?? 1, requestItem: requestItem, params: params)
            .tryMap { data -> T in
                do {
                    // Convert Data to String to check if it's a plain text response
                    if let responseString = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines),
                       !requestItem.responseInJson {
                        
                        // Manually create SimpleStringResponse and cast to generic T
                        let stringResponse = SimpleStringResponse(message: responseString)
                        return stringResponse as! T
                    }
                    
                    // If JSON is expected, decode using JSONDecoder
                    return try JSONDecoder().decode(T.self, from: data)
                    
                } catch let decodingError as DecodingError {
                    let error = self.detailedErrorMessage(for: decodingError)
//                    print(error)
                    throw NetworkError.decodingFailed(error)
                } catch {
                    throw NetworkError.custom(error.localizedDescription)
                }
            }
            .mapError { error in
                if let urlError = error as? URLError {
                    return NetworkError.custom(urlError.localizedDescription)
                } else {
                    return NetworkError.custom(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private methods
    private func data(urlRequest: URLRequest, triesLeft: Int = 2, requestItem: RequestItems, params: [String: Any]?) -> AnyPublisher<Data, Error> {
        
        func publisher(forDataTaskOutput output: URLSession.DataTaskPublisher.Output) -> AnyPublisher<Data, Error> {
            let httpResponse = output.response as? HTTPURLResponse
//            print(httpResponse?.allHeaderFields ?? [:])
            if let cookieHeader = httpResponse?.allHeaderFields["Set-Cookie"] as? String, requestItem.isCookieAllow {
            }
            
            let data = try? JSONDecoder().decode(CommonAPIResponse.self, from: output.data)
#if DEBUG
//                logger.log(responseData: output.data, response: httpResponse)
#endif
            switch (output.response as? HTTPURLResponse)?.statusCode {
            case .some(200...300):
                return Result.success(output.data).publisher.eraseToAnyPublisher()
            case .some(400), .some(500):
                self.signOut(errorMessage: data?.message ?? "")
                return Fail(error: NetworkError.responseError(data?.message ?? "Unexpected status code")).eraseToAnyPublisher()
            case .some(401):
                self.signOut(errorMessage: data?.message ?? "")
                return Fail(error: NetworkError.responseError(data?.message ?? "Unauthorized")).eraseToAnyPublisher()
            default:
                self.signOut(errorMessage: data?.message ?? "User not found")
                return Fail(error: NetworkError.responseError(data?.message ?? "Unexpected status code")).eraseToAnyPublisher()
            }
        }
        
        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error in
                NetworkError.custom(error.localizedDescription)
            }
            .flatMap(publisher(forDataTaskOutput:))
            .retry(2)
            .eraseToAnyPublisher()
    }
    
    public func makeWebSocketTask(requestItem: RequestItems) throws -> URLSessionWebSocketTask {
        guard let url = requestItem.url else {
            throw NetworkError.invalidURL
        }
        let webSocketTask = URLSession.shared.webSocketTask(with: url)
        return webSocketTask
    }
}

// MARK: - Get URLRequest
extension NetworkManager {
    private func getURLRequest(requestItem: RequestItems, param: [String: Any]?) -> URLRequest? {
        guard let url = requestItem.url else { return nil }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = requestItem.httpMethod.getMethod
        
        if let header = requestItem.header {
            request.allHTTPHeaderFields = header
        }

        // Use URLComponents to build URL with query items for GET requests
        if requestItem.httpMethod == .GET, let queryItems = requestItem.queryItems, !queryItems.isEmpty {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = queryItems
            request.url = urlComponents?.url
        } else {
            request.url = url
            
            // For non-GET methods, add params to the request body
            if let param = param, !param.isEmpty {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
                } catch {
//                    print("invalid json formate of params")
                }
            }
        }
#if DEBUG
//        logger.log(request: request)
#endif
        return request
    }
}

extension NetworkManager {
    // Helper function to create detailed error messages
    private func detailedErrorMessage(for decodingError: DecodingError) -> String {
        switch decodingError {
        case .keyNotFound(let key, let context):
            return "Key '\(key.stringValue)' not found: \(context.debugDescription). CodingPath: \(context.codingPath.map { $0.stringValue })"
        case .typeMismatch(let type, let context):
            return "Type '\(type)' mismatch: \(context.debugDescription). CodingPath: \(context.codingPath.map { $0.stringValue })"
        case .valueNotFound(let value, let context):
            return "Value '\(value)' not found: \(context.debugDescription). CodingPath: \(context.codingPath.map { $0.stringValue })"
        case .dataCorrupted(let context):
            return "Data corrupted: \(context.debugDescription). CodingPath: \(context.codingPath.map { $0.stringValue })"
        @unknown default:
            return "Unknown decoding error: \(decodingError.localizedDescription)"
        }
    }
}

// MARK: - SignOut app
extension NetworkManager {
    
    private func signOut(errorMessage: String) {
        UserPreferences.shared.clearUserInfo()
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NotificationNames.networkError, object: NetworkError.authorizationError(errorMessage))
        }
    }
}
