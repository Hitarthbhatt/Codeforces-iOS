//
//  NetworkErrorLogger.swift
//  Platform
//
//  Created by Ankit Panchotiya on 18/07/25.
//

import Foundation

public protocol NetworkErrorLogger {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}
