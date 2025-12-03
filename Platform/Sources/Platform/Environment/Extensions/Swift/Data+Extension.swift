import Foundation

public extension Data {
    
    var utf8EncodedString: String? {
        return String(data: self, encoding: .utf8)
    }
    
    var prettyJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
            return nil
        }
        return data.debugDescription
    }
    
    mutating func append(string: String, encoding: String.Encoding = .utf8) {
        guard let data = string.data(using: encoding) else { return }
        self.append(data)
    }
    
}
