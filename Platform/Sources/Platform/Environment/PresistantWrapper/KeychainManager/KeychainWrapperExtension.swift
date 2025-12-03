import Foundation

extension KeychainManager: KeyValueDiskStorage {

    @discardableResult
    func encode<Value: Encodable>(
        value: Value,
        for key: PersistentStorageKeys,
        encoder: DataEncoder
    ) -> Bool {
        guard let data = try? encoder.encode(value) else {
            return false
        }
        return self.save(data, for: key)
    }

    func decode<Value: Decodable>(for key: PersistentStorageKeys, decoder: DataDecoder) -> Value? {
        guard let data = self.retrieve(for: key) else {
            return nil
        }
        return try? decoder.decode(Value.self, from: data)
    }

    func value<Value>(for key: PersistentStorageKeys) -> Value? {
        switch Value.self {
        case is String.Type:
            return self.retrieve(for: key) as? Value
        default:
            print("Value type: \(Value.self) can not be retrieved for key: \(key)")
            return nil
        }
    }

    @discardableResult func set<Value>(
        value: Value,
        for key: PersistentStorageKeys
    ) -> Bool {
        switch value {
        case let someString as String:
            self.saveToken(for: key, value: someString)
            return true
        default:
            print("Value type: \(value.self) can not be set for key: \(key)")
            return false
        }
    }

    @discardableResult func removeObject(for key: PersistentStorageKeys) -> Bool {
        return self.delete(for: key)
    }
}
