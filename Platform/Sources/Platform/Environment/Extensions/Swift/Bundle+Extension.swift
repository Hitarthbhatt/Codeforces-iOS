//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 04/02/25.
//

import Foundation

public extension Bundle {
    func decode<T: Decodable>(
        _ file: String,
        withExtension type: String = "json"
    ) async throws -> T {
        guard let url = self.url(forResource: file, withExtension: type) else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
