//
//  CommonAPIResponse.swift
//  
//
//  Created by Ankit panchotiya on 28/06/24.
//

import Foundation

struct CommonAPIResponse: Codable {
    let success: Bool
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case success, message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success) ?? false
        message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
}
