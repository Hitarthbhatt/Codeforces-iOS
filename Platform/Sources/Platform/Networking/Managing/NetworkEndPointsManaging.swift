//
//  EndPointsManaging.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 22/05/24.
//

import Foundation

protocol EndPoints {
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}
