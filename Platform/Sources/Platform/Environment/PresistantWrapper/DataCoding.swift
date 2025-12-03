import Foundation

public protocol DataEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

public protocol DataDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONEncoder: DataEncoder {}
extension JSONDecoder: DataDecoder {}
