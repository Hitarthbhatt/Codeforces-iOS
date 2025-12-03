//
//  KeychainManager.swift
//  CandleCast
//
//  Created by Ankit panchotiya on 24/02/25.
//

import Foundation
import Security

public final class KeychainManager: KeychainManaging {

    static public let shared = KeychainManager()

    public func saveToken(for key: PersistentStorageKeys, value: String) {
        guard let value = value.data(using: .utf8) else { return }
        let isNewKey = readToken(for: key) == nil

        if isNewKey {
            createNewToken(for: key, value: value)
        } else {
            updateToken(for: key, value: value)
        }
    }

    public func readToken(for key: PersistentStorageKeys) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.keyName,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        let _ = SecItemCopyMatching(query, &result)
        let dictionary = result as? NSDictionary
        if let data = dictionary?[kSecValueData] as? Data,
           let token = String(data: data, encoding: .utf8) {
            return token
        }
        return nil
    }

    public func deleteToken(for key: PersistentStorageKeys) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.keyName
        ] as CFDictionary

        let status = SecItemDelete(query)
        print("Deleted the token from the Keychain with status:", status)
    }

    private func createNewToken(for key: PersistentStorageKeys, value: Data) {
        let keychainItem = [
            kSecAttrAccount: key.keyName,
            kSecValueData: value,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary

        let status = SecItemAdd(keychainItem, nil)
        print("Created a token entry in the Keychain with status:", status)
    }

    private func updateToken(for key: PersistentStorageKeys, value: Data) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.keyName
        ] as CFDictionary

        let updateFields = [
            kSecValueData: value
        ] as CFDictionary

        let status = SecItemUpdate(query, updateFields)
        print("Updated the token entry in the Keychain with status:", status)
    }
}

public extension KeychainManager {

    func save(_ data: Data, for key: PersistentStorageKeys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.keyName,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)

        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    func retrieve(for key: PersistentStorageKeys) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.keyName,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        guard status == errSecSuccess else { return nil }
        return dataTypeRef as? Data
    }

    func delete(for key: PersistentStorageKeys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.keyName
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
