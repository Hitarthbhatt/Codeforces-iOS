import Foundation

protocol KeyValueDiskStorage: AnyObject {
    
    @discardableResult func encode<Value: Encodable>(
        value: Value,
        for key: PersistentStorageKeys,
        encoder: DataEncoder
    ) -> Bool
    
    func decode<Value: Decodable>(
        for key: PersistentStorageKeys,
        decoder: DataDecoder
    ) -> Value?
    
    func value<Value>(for key: PersistentStorageKeys) -> Value?
    
    @discardableResult func set<Value>(
        value: Value,
        for key: PersistentStorageKeys
    ) -> Bool
    
    @discardableResult func removeObject(for key: PersistentStorageKeys) -> Bool
    
}

extension KeyValueDiskStorage {
    
    @discardableResult func encode<Value: Encodable>(
        value: Value,
        for key: PersistentStorageKeys
    ) -> Bool {
        return self.encode(value: value, for: key, encoder: JSONEncoder())
    }
    
    func decode<Value: Decodable>(for key: PersistentStorageKeys) -> Value? {
        return self.decode(for: key, decoder: JSONDecoder())
    }
    
}
