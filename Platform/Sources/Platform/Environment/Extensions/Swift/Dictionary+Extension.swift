//
//  Dictionary+Extension.swift
//  Environment
//
//  Created by Ankit Panchotiya on 18/01/25.
//

import Foundation

public extension Dictionary {
    
    func toData() throws -> Data? {
        return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
    var queryString: String {
        var output: String = ""
        var alreadyUsedRepeatedKey: String = ""
        for (key, value) in self {
            if "\(key)" == "singleRepeate" {
                alreadyUsedRepeatedKey = "\(value)"
                output = getRepeatedKeyQuery(key1: "\(value)")
            } else {
                if alreadyUsedRepeatedKey != "\(key)" {
                    output +=  "\(key)=\(value)&"
                }
            }
        }
        output = String(output.dropLast())
        return output
    }
    
    private func getRepeatedKeyQuery(key1: String) -> String {
        var output: String = ""
        for (key, _) in self where "\(key)" == key1 {
            if let arr = self[key] as? [Any] {
                for item in arr {
                    output += "\(key1)=\(item)&"
                }
            }
        }
        return output
    }
}
