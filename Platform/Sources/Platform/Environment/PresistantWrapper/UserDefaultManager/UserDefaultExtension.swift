//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 20/02/25.
//

import Foundation

extension UserDefaults: KeyValueDiskStorage {

    func encode<Value: Encodable>(
        value: Value,
        for key: PersistentStorageKeys,
        encoder: any DataEncoder
    ) -> Bool {
        guard let data = try? encoder.encode(value) else {
            return false
        }
        return self.set(value: data, for: key)
    }

    func decode<Value: Decodable>(
        for key: PersistentStorageKeys,
        decoder: any DataDecoder
    ) -> Value? {
        guard let data = self.data(forKey: key.keyName) else {
            return nil
        }
        return try? decoder.decode(Value.self, from: data)
    }

    func value<Value>(for key: PersistentStorageKeys) -> Value? {
        switch Value.self {
        case is Int.Type:
            return self.integer(forKey: key.keyName) as? Value
        case is Float.Type:
            return self.float(forKey: key.keyName) as? Value
        case is Double.Type:
            return self.double(forKey: key.keyName) as? Value
        case is Bool.Type:
            return self.bool(forKey: key.keyName) as? Value
        case is String.Type:
            return self.string(forKey: key.keyName) as? Value
        case is Data.Type:
            return self.data(forKey: key.keyName) as? Value
        default:
            print("Value type: \(Value.self) can not be retrieved for key: \(key)")
            return nil
        }
    }

    func set<Value>(value: Value, for key: PersistentStorageKeys) -> Bool {
        switch value {
        case let someInt as Int:
            self.set(someInt, forKey: key.keyName)
        case let someFloat as Float:
            self.set(someFloat, forKey: key.keyName)
        case let someDouble as Double:
            self.set(someDouble, forKey: key.keyName)
        case let someBool as Bool:
            self.set(someBool, forKey: key.keyName)
        case let someString as String:
            self.set(someString, forKey: key.keyName)
        case let someData as Data:
            self.set(someData, forKey: key.keyName)
        default:
            print("Value type: \(value.self) can not be set for key: \(key)")
        }
        return self.synchronize()
    }

    func removeObject(for key: PersistentStorageKeys) -> Bool {
        self.removeObject(forKey: key.keyName)
        return self.synchronize()
    }
}
