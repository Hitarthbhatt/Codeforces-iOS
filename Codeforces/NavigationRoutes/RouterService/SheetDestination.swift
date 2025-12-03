import SwiftUI
import PhotosUI

enum SheetDestination: Identifiable, Hashable, Equatable {
    case textEditorTool

    var id: String {
        switch self {
        case .textEditorTool:
            return "textEditorTool"
        }
    }

    static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
