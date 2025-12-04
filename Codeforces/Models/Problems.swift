//
//  Problems.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 03/12/25.
//

import Foundation

// MARK: - Result
struct ProblemList: Codable {
    let problems: [Problem]?
    let problemStatistics: [ProblemStatistic]?
}

// MARK: - ProblemStatistic
struct ProblemStatistic: Codable {
    let contestID: Int?
    let index: String?
    let solvedCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case contestID = "contestId"
        case index, solvedCount
    }
}

// MARK: - Problem
struct Problem: Codable, Identifiable {
    let id: UUID = UUID() 
    let contestID: Int?
    let index: String?
    let name: String?
    let rating: Int?
    let tags: [Tag]?
    let points: Int?
    
    enum CodingKeys: String, CodingKey {
        case contestID = "contestId"
        case index, name, rating, tags, points
    }
}

enum Tag: String, Codable {
    case binarySearch = "binary search"
    case bitmasks = "bitmasks"
    case bruteForce = "brute force"
    case combinatorics = "combinatorics"
    case constructiveAlgorithms = "constructive algorithms"
    case dataStructures = "data structures"
    case dfsAndSimilar = "dfs and similar"
    case divideAndConquer = "divide and conquer"
    case dp = "dp"
    case dsu = "dsu"
    case expressionParsing = "expression parsing"
    case fft = "fft"
    case flows = "flows"
    case games = "games"
    case geometry = "geometry"
    case graphMatchings = "graph matchings"
    case graphs = "graphs"
    case greedy = "greedy"
    case hashing = "hashing"
    case implementation = "implementation"
    case interactive = "interactive"
    case math = "math"
    case matrices = "matrices"
    case meetInTheMiddle = "meet-in-the-middle"
    case numberTheory = "number theory"
    case probabilities = "probabilities"
    case schedules = "schedules"
    case shortestPaths = "shortest paths"
    case sortings = "sortings"
    case special = "*special"
    case stringSuffixStructures = "string suffix structures"
    case strings = "strings"
    case ternarySearch = "ternary search"
    case trees = "trees"
    case twoPointers = "two pointers"
    case unknown = "unknown"
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = Tag(rawValue: rawValue) ?? .unknown
    }
}
