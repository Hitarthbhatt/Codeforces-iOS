//
//  DefaultNetworkErrorLogger.swift
//  Platform
//
//  Created by Ankit Panchotiya on 18/07/25.
//

import Foundation

final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    
    private let logger: LoggerLocalLog
    
    init(logger: LoggerLocalLog) {
        self.logger = logger
    }
    
    func log(request: URLRequest) {
        var logString = ""
        logString.append("------------")
        logString.append("\n⬆️ REQUEST")
        logString.append("\nURL: \(request.url!)")
        logString.append("\nHEADERS: \(request.allHTTPHeaderFields!)")
        logString.append("\nMETHOD: \(request.httpMethod!)")
        if let httpBody = request.httpBody {
            if let jsonString = String(data: httpBody, encoding: .utf8) {
                logString.append("\n📦 BODY: \(jsonString)")
            } else {
                print("MULTIPARTBODY: \(httpBody.count)")
            }
        }
        logString.append("\n------------")
#if DEBUG
        logger.log(logString, type: .network)
#endif
    }
    
    public func log(responseData data: Data?, response: URLResponse?) {
        var logString = ""
        logString.append("------------")
        logString.append("\n⬇️ RESPONSE")
        logString.append("\n🏠 URL: \(response?.url?.absoluteString ?? "unknown")")
        if let response = response as? HTTPURLResponse {
            let emoji = (200...299).contains(response.statusCode) ? "✅" : "❌"
            logString.append("\n\(emoji) STATUS: \(response.statusCode)")
        }
        
        if let data, let jsonString = String(data: data, encoding: .utf8) {
            if jsonString == "" {
                logString.append("\n📦 BODY: EMPTY DATA")
            } else {
                logString.append("\n📦 BODY: \(jsonString)")
            }
        } else {
            logString.append("\n📦 NO BODY DATA.")
        }
        
        logString.append("\n------------")
#if DEBUG
        logger.log(logString, type: .network)
#endif
    }
    
    public func log(error: Error) {
    }
}

