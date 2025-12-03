//
//  BaseModel.swift
//  IGM
//
//  Created by Ankit Panchotiya on 16/10/24.
//

import Foundation

public struct BaseModel<T: Codable>: Codable {
    public let status: String
    public let result: T
}

public struct SimpleStringResponse: Decodable {
    public let message: String
}
