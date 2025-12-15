//
//  UserInfo.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 10/12/25.
//

import Foundation

struct UserInfo: Codable {
    let contribution: Int?
    let lastOnlineTimeSeconds: Int?
    let rating: Int?
    let friendOfCount: Int?
    let titlePhoto: String?
    let rank, handle: String?
    let maxRating: Int?
    let avatar: String?
    let registrationTimeSeconds: Int?
    let maxRank: String?
}
