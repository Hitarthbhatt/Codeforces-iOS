import SwiftUI
import PhotosUI

enum SheetDestination: Identifiable, Hashable, Equatable {
    case problemTags(tags: [Tag])

    var id: String {
        switch self {
        case .problemTags:
            return "problemTags"
        }
    }

    static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
