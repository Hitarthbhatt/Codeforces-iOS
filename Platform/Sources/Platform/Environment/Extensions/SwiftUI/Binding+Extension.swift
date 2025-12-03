import SwiftUI

public extension Binding where Value: ExpressibleByNilLiteral {
    func toNonOptional<T>(defaultValue: @autoclosure @escaping () -> T) -> Binding<T> where Value == T? {
        return Binding<T>(
            get: {
                return self.wrappedValue ?? defaultValue()
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}
