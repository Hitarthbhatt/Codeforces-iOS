import SwiftUI

enum FullScreenCoverDestination: Identifiable, Hashable {
    public static func == (lhs: FullScreenCoverDestination, rhs: FullScreenCoverDestination) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    case camera(allowsEditing: Bool = false, onSelect: (UIImage) -> Void)
    
    public var id: String {
        switch self {
        case .camera: "camera"
        }
    }
}
