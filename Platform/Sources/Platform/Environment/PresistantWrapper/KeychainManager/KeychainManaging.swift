//
//  KeychainManaging.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 24/02/25.
//

import Foundation

public protocol KeychainManaging {
    func saveToken(for key: PersistentStorageKeys, value: String)
    func readToken(for key: PersistentStorageKeys) -> String?
    func deleteToken(for key: PersistentStorageKeys)
    func save(_ data: Data, for key: PersistentStorageKeys) -> Bool
    func retrieve(for key: PersistentStorageKeys) -> Data?
    func delete(for key: PersistentStorageKeys) -> Bool
}

